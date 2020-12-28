import apolloClient from 'siskom-web-admin/apolloClient.js';
import GQLSessionData from 'siskom-web-admin/graphql/SessionData.js';
import * as stores from 'siskom-web-admin/stores/index.js';

export default async function updateSession () {
  const result = await apolloClient.query({
    query: GQLSessionData
  })

  const {
    user,
    setting
  } = result.data;
  const {
    periode,
    phase
  } = setting;

  if (!phase) {
    throw new Error('empty phase');
  }
  if (!periode) {
    throw new Error('empty active periode'); 
  }

  stores.periode.set(periode);
  stores.phase.set(phase);
  stores.user.set(user);

  console.log('periode');
  console.log(periode);
}
