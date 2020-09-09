import { gql } from '@apollo/client/core';

export default gql`
  query KHS($idMahasiswa: Int!, $idPeriode: Int!) {
    kelasInPeriode(
      _idMahasiswa: $idMahasiswa, 
      _idPeriode: $idPeriode
    ) {
      nodes {
        id
        nilai
        kelas: kelaByIdKelas {
          id
          label
          mk: mataKuliahByIdMk {
            id
            kode
            nama
            sks
            tipeMk
          }
        }
      }
      totalCount
    }

    infoTranskripPeriode (
      _idMahasiswa: $idMahasiswa
      _idPeriode: $idPeriode
    ) {
      sks
      sksd
      sksn
      ip
    }
  }
`