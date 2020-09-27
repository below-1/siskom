const { makeExtendSchemaPlugin, gql } = require("graphile-utils");
const redis = require('../redis');

const KrsPlugin = makeExtendSchemaPlugin(build => {
  return {
    typeDefs: gql`
    	type KrsRow {
    		kode: String!
    		nama: String!
    		sks: Int!
    		kelas: String
    		ruang: String
    		waktuKul: Time
    		totalMenit: Time
    	}

      extend type Query {
      	mahasiswaKrs (_idPeriode: Int!, _idMahasiswa: Int!): [KrsRow!]!
      }
    `,
    resolvers: {
      Query: {
        async mahasiswaKrs (parent, args, context, info) {
        	// Query redis here
        	const key = `siskom.krs#mhs_1:periode_2`;
        	const data = await redis.get(key);
        	// if data is not in cache
        	// get from sql db
        	// then store back to cache.
        	const { pgClient } = context;
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