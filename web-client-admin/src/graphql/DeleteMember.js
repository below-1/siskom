import { gql } from '@apollo/client/core';

export default gql`
  mutation DeleteKelasMember($idMahasiswa: Int!, $idKelas: Int!) {
    deleteMahasiswaKelaByIdKelasAndIdMhs (input: {
      idMhs: $idMahasiswa,
      idKelas: $idKelas
    }) {
      mahasiswaKela {
        idMhs
        idKelas
      }
    }
  }
`