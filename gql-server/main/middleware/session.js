const session = require('express-session')
const RedisStore = require('connect-redis')(session)
const redis = require('../storage/redis')

module.exports = session({
	store: new RedisStore({ client: redis }),
	secret: process.env.EXPRESS_SESSION_SECRET,
	resave: false
})
