import { gql } from '@apollo/client/core';

export default gql`
  mutation DeleteMahasiswa($id: Int!) {
    deleteMahasiswaById (input: { id: $id }) {
      mahasiswa {
        id
      }
    }
  }
`
