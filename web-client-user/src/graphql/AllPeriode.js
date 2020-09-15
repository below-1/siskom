import { gql } from '@apollo/client/core';

export default gql`
  query ScheduleRequired {
    allPeriodes {
      nodes {
        id
        tahun
        semester
      }
    }
  }
`