import { gql } from '@apollo/client/core';

export default gql`
  mutation UpdateMKById ($id: Int!, $payload: MataKuliahPatch!) {
    updateMataKuliahById (input: {
      id: $id,
      mataKuliahPatch: $payload
    }) {
      mataKuliah {
        id
      }
    }
  }
`
