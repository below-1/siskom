const http = require('http');
const { postgraphile } = require('postgraphile');
const { makeExtendSchemaPlugin, gql } = require("graphile-utils");
const ConnectionFilterPlugin = require("postgraphile-plugin-connection-filter")

const TestSchemaPlugin = makeExtendSchemaPlugin(build => {
  return {
    typeDefs: gql`
      type FooBar {
        name: String!
        age: Int!
        height: Float!
      }

      extend type Query {
        someFoo: FooBar!
      }
    `,
    resolvers: {
      Query: {
        someFoo (parent, args, context, info) {
          return {
            name: 'AssHoe',
            age: 24,
            height: 163.4
          }
        }
      }
    }
  }
});

http
  .createServer(
    postgraphile(
      process.env.DATABASE_URL || 'postgres://postgres@localhost/postgres',
      'public',
      {
        graphiql: true,
        enhanceGraphiql: true,
        dynamicJson: true,
        enableCors: true,
        jwtPgTypeIdentifier: 'public.app_user_jwt',
        jwtSecret: 'quos8934sdsd8932sdsajUIUssa',
        appendPlugins: [
          ConnectionFilterPlugin,
          TestSchemaPlugin
        ],
        graphileBuildOptions: {
          connectionFilterAllowNullInput: true
        }
      }
    )
  )
  .listen(process.env.PORT || 5000);
