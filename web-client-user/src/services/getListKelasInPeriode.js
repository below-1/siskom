import apolloClient from 'siskom-web-user/apolloClient.js';

export default async function getListKelasInPeriode ({
	idPeriode
}) {
	const result = await apolloClient.query({
		query: GQLKelasInPeriode,
		variables: {
			idPeriode
		}
	})
	return result.data.
}