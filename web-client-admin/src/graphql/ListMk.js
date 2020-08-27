import { gql } from '@apollo/client/core';

export default gql`
  query ListMataKuliah($tipeMk: MkType, $openIn: MkOpenInType, $keyword: String, $take: Int!) {
    allMataKuliahs(
      filter: {
        tipeMk: {equalTo: $tipeMk},
        openIn: {equalTo: $openIn},
        or: [
          { nama: { likeInsensitive: $keyword } },
          { kode: { likeInsensitive: $keyword } }
        ]
      },
      first: $take
    ) {
      nodes {
        id
        kode
        minSks
        nama
        nodeId
        openIn
        prefSchedule
        sks
        tipeMk
      }
      pageInfo {
        hasNextPage
        hasPreviousPage
      }
    }
  }
`