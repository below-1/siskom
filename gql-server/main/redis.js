const Redis = require('ioredis')

module.exports = ({ redis_url }) => new Redis(redis_url)
