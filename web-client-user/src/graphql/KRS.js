import { gql } from '@apollo/client/core';

export default gql`
  query KRS($idMahasiswa: Int!, $idPeriode: Int!) {
    kelasInPeriode(
      _idMahasiswa: $idMahasiswa, 
      _idPeriode: $idPeriode
    ) {
      nodes {
        id
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
  }
`