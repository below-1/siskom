import { gql } from '@apollo/client/core';

export default gql`
  query CurrentUser {
    currentAppUser {
      id
      targetId
      username
      username
      tipeUser
      scopes
    }
  }`;
