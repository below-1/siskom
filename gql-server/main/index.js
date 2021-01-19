require('dotenv').config()

const Polka = require('polka')
const session = require('./middleware/session')
const postgraphile = require('./middleware/postgraphile')
const routesAuth = require('./routes/auth')
const cors = require('cors')
const send = require('@polka/send-type')

const app = Polka()

app
	.use(session)
	.use(cors({
		origin: ['http://localhost:5002','http://localhost:5001'],
		credentials: true
	}))
	.get('/', (req, resp) => {
		send(resp, 200, { message: 'okay' })
	})
	.use('/api', postgraphile)

routesAuth(app)

app.listen(process.env.PORT, (err) => {
	if (err) {
		process.exit()
	}
	console.log('server is up and running')
	// console.log(`running at ${app.address().host}:${app.address().port}`);
})