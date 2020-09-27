require('dotenv').config()

// const express = require('express')
const polka = require('polka')
const cors = require('cors')
const session = require('./middleware/session')
const postgraphile = require('./middleware/postgraphile')

const app = polka()

app
	.use(session)
	.use(cors())
	.use('/api', postgraphile)

app.listen(process.env.PORT, (err) => {
	if (err) {
		process.exit()
	}
	console.log('server is up and running')
	// console.log(`running at ${app.address().host}:${app.address().port}`);
})