const PgPool = require('../storage/pg');
const { postgraphile } = require('postgraphile')
const ConnectionFilterPlugin = require("postgraphile-plugin-connection-filter")

module.exports = postgraphile(
  PgPool,
  process.env.DB_SCHEMA,
  {
    graphiql: process.env.NODE_ENV != 'production',
    enhanceGraphiql: true,
    dynamicJson: true,
    jwtPgTypeIdentifier: 'public.app_user_jwt',
    jwtSecret: process.env.JWT_SECRET,
    appendPlugins: [
      ConnectionFilterPlugin
    ],
    graphileBuildOptions: {
      connectionFilterAllowNullInput: true
    },
    pgSettings: async req => {
      console.log(req.session);
      return {
        'siskom.user_id': req.session.user_id
      }
    }
  }
)