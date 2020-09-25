import { gql } from '@apollo/client/core';

export default gql`
  query AllPeriodes {
    allPeriodes {
      nodes {
        id
        tahun
        semester
      }
    }
  }
`