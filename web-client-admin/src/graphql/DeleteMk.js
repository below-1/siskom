import { gql } from '@apollo/client/core';

export default gql`
  mutation DeleteById ($id: Int!) {
    deleteMataKuliahById (input :  {
      id: $id
    }) {
      mataKuliah {
        id
      }
    }
  }
`
