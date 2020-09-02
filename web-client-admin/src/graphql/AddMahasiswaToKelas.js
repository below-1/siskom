import { gql } from '@apollo/client/core';

export default gql`
  mutation AddMahasiswaToKelas ($idMahasiswa: Int!, $idKelas: Int!) {
    addMahasiswaToKelas(input: {
      _idMahasiswa: $idMahasiswa
      _idKelas: $idKelas
    }) {
      integer
    }
  }
`