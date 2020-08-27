import { gql } from '@apollo/client/core';

export default gql`
  mutation CreateMataKuliah($payload: MataKuliahInput!) {
    createMataKuliah (
      input: {
        mataKuliah: $payload
      }
    ) {
      mataKuliah {
        id
      }
    }
  }
`
