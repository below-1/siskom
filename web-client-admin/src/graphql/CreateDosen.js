import { gql } from '@apollo/client/core';

export default gql`
  mutation CreateDosen($payload: NewDosenInput!) {
    newDosen (input: $payload) {
      dosen {
        id
      }
    }
  }`
