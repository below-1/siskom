const pg = require('pg')

const pool = new pg.Pool({
	connectionString: process.env.DB_URL
})
module.exports = pool