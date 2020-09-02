import { gql } from '@apollo/client/core';

export default gql`
  mutation DeletePeriodeById($id: Int!) {
    deletePeriodeById (input: {
      id: $id
    }) {
      periode {
        id
      }
    }
  }
`