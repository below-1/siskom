import { ApolloClient, HttpLink, ApolloLink, concat } from '@apollo/client/core';
import cache from './apolloCache.js';

const authMiddleware = new ApolloLink((operation, forward) => {
  const token = localStorage.getItem('siskom.token');
  const headers = token 
    ? { Authorization: `Bearer ${token}` }
    : {};
  operation.setContext({
    headers
  });

  return forward(operation);
});

const httpLink = new HttpLink({
  uri: 'http://localhost:5000/graphql',
});

export default new ApolloClient({
  cache,
  link: concat(authMiddleware, httpLink)
});