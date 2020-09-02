import { gql } from '@apollo/client/core';

export default gql`
  mutation DeleteMahasiswaKelas ($idMahasiswaKelas: Int!) {
    deleteMahasiswaKelaById(input: {
      id: $idMahasiswaKelas
    }) {
      deletedMahasiswaKelaId
    }
  }
`