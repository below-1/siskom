import { gql } from '@apollo/client/core';

export default gql`
  query Transkrip(
    $id: Int!
    $tahun: Int!
    $semester: Int!
    $take: Int!
    $after: Cursor
    $keyword: String
  ) {
    transkrip(
      _idMahasiswa: $id
      _tahun: $tahun
      _semester: $semester
      _keyword: $keyword
      first: $take
      after: $after,
    ) {
      edges {
        cursor
        node {
          idKelas
          idMk
          namaMk
          kodeMk
          tipeMk
          label
          tahun
          semester
          nilai
          lulus
          sks
          tahun
          semester
        }
      }
      pageInfo {
        hasNextPage
      }
      totalCount
    }
  }
`