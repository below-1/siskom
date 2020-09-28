const bodyParser = require('body-parser')
const Pool = require('../storage/pg')
const send = require('@polka/send-type')

class AuthError extends Error {
	constructor () {
		super('User not found in database')
		this.name = 'UserNotFound'
	}
}

async function login (request, response) {
	const {
		username,
		password
	} = request.body
	let status = 200
	let result;

	const query = `
		select * from app_user
			where 
				username = $1
				and password = crypt($2, password)
	`
	try {
		const pgResult = await Pool.query(query, [username, password])
		if (pgResult.rows.length == 0) {
			throw new AuthError()
		}
		const user = pgResult.rows[0]
		request.session.user_id = user.id
		result = user
	} catch (err) {
		console.log(err)
		if (err instanceof AuthError) {
			status = 401
			result = { message: 'error authenticating user' }
		} else {
			status = 500
			result = { message: 'database error' }
		}
	}
	send(response, status, result)
}

async function test_session (request, response) {
	console.log(request.session)
	send(response, 200, {
		message: 'ok'
	})
}

async function logout (request, response) {
	response.end('logout')
}

module.exports = (app) => {
	app.use('/auth', bodyParser.json())
	app.post('/auth/login', login)
	app.get('/auth/logout', logout)
	app.get('/auth/test_session', test_session)
}