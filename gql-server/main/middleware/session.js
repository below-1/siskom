const session = require('express-session')
const connectRedis = require('connect-redis')

const RedisStore = connectRedis(session)
const redis = require('../storage/redis')

module.exports = session({
	store: new RedisStore({ client: redis }),
	secret: process.env.EXPRESS_SESSION_SECRET,
	resave: false,
	saveUninitialized: false
})
