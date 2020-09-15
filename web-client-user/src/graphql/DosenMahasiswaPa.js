import { gql } from '@apollo/client/core';

export default gql`
  query AllMahasiswas(
    $first: Int!,
    $keyword: String
    $after: Cursor
    $tahunMasuk: ThAjar!
    $idDosen: Int!
  ) {
    allMahasiswas (
      first: $first,
      after: $after,
      filter: {
        and: { 
          tahunMasuk: { equalTo: $tahunMasuk }
          idPa: { equalTo: $idDosen }
          nama: { likeInsensitive: $keyword }
        }
      }
    ) {
      edges {
        cursor
        node {
          id
          nama
          nim
          sex
          status
        }
      }
    }
  }
`