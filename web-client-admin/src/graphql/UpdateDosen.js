import { gql } from '@apollo/client/core';

export default gql`
  mutation UpdateDosen($id: Int!, $payload: DosenPatch!) {
    updateDosenById(input: {
      id: $id,
      dosenPatch: $payload
    }) {
      dosen {
        id
      }
    }
  }
`