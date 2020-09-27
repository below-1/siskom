const Pool = require('../storage/pg');
const { postgraphile } = require('postgraphile')
const ConnectionFilterPlugin = require("postgraphile-plugin-connection-filter")

module.exports = postgraphile(
  Pool,
  process.env.DB_SCHEMA,
  {
    graphiql: process.env.NODE_ENV != 'production',
    enhanceGraphiql: true,
    dynamicJson: true,
    enableCors: true,
    jwtPgTypeIdentifier: 'public.app_user_jwt',
    jwtSecret: process.env.JWT_SECRET,
    appendPlugins: [
      ConnectionFilterPlugin
    ],
    graphileBuildOptions: {
      connectionFilterAllowNullInput: true
    }
  }
)