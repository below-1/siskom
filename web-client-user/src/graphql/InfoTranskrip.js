import { gql } from '@apollo/client/core';

export default gql`
  query InfoTranskrip(
    $id: Int!
    $tahun: Int!
    $semester: Int!
  ) {
    infoTranskripKumulatif (
      _idMahasiswa: $id,
      _tahun: $tahun
      _semester: $semester
    ) {
      sks
      sksd
      sksn
      ip
    }
  }

`