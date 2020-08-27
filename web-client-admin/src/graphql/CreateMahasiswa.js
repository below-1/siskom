import { gql } from '@apollo/client/core';

export default gql`
  mutation CreateMahasiswa($payload: NewMahasiswaInput!) {
    newMahasiswa (input: $payload) {
      integer
    }
  }
`
