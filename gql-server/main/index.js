require('dotenv').config()

const express = require('express')
const cors = require('cors')
const session = require('./middleware/session')
const postgraphile = require('./middleware/postgraphile')

const app = express()

app.use(session)
app.use(cors())
app.use('/api', postgraphile)

app.listen(process.env.PORT, (err) => {
	if (err) {
		process.exit()
	}
	console.log('server is up and running')
	// console.log(`running at ${app.address().host}:${app.address().port}`);
})