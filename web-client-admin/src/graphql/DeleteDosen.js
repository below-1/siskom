import { gql } from '@apollo/client/core';

export default gql`
  mutation DeleteDosen($id: Int!) {
    deleteDosenById(input: { id: $id }) {
      dosen {
        id
      }
    }
  }`
