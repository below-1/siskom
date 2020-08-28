import { gql } from '@apollo/client/core';

export default gql`
  mutation DeleteKelasById ($id: Int!) {
    deleteKelaById(input: { id: $id }) {
      kela {
        id
      }
    }
  }
`
