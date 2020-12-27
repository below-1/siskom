import { ApolloClient, HttpLink, ApolloLink, concat } from '@apollo/client/core';
import cache from './apolloCache.js';

const token = localStorage.getItem('siskom.token');
const headers = token 
  ? { Authorization: `Bearer ${token}` }
  : {};
const authMiddleware = new ApolloLink((operation, forward) => {
  operation.setContext({
    headers
  });

  return forward(operation);
});

const httpLink = new HttpLink({
  uri: 'http://localhost:5000/api/graphql',
});

export default new ApolloClient({
  connectToDevTools: true,
  cache,
  link: concat(authMiddleware, httpLink)
});
