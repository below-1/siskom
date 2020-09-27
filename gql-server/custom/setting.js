const { makeExtendSchemaPlugin, gql } = require("graphile-utils");
const redis = require('../redis');

const SettingPlugin = makeExtendSchemaPlugin(build => {
	return {
		typedefs: gql`
			
		`,
		resolvers: {
			Query: {
				
			}
		}
	}
});