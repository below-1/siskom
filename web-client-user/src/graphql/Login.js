import { gql } from '@apollo/client/core';

export default gql`
  mutation Login(
    $username: String!
    $password: String!
  ) {
    login (input: {
      _username: $username
      _password: $password
    }) {
      token: appUserJwt
    }
  }`;
