require('dotenv').config()

const Polka = require('polka')
const session = require('./middleware/session')
const postgraphile = require('./middleware/postgraphile')
const routesAuth = require('./routes/auth')
const cors = require('cors')

const app = Polka()

app
	.use(session)
	.use(cors())
	.use('/api', postgraphile)

routesAuth(app)

app.listen(process.env.PORT, (err) => {
	if (err) {
		process.exit()
	}
	console.log('server is up and running')
	// console.log(`running at ${app.address().host}:${app.address().port}`);
})