import { gql } from '@apollo/client/core';

export default gql`
  query AllDosens($keyword: String!) {
    allDosens(
      filter: {
        or: [
          { nip: { likeInsensitive: $keyword } }
          { nama: { likeInsensitive: $keyword }}
        ]
      }
    ) {
      totalCount
      nodes {
        id
        nama
        nip
        nodeId
        status
        sex
      }
    }
  }`
