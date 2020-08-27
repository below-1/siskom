import { gql } from '@apollo/client/core';

export default gql`
  mutation UpdateMahasiswaById($id: Int!, $payload: MahasiswaPatch!) {
    updateMahasiswaById (input: {
      mahasiswaPatch: $payload,
      id: $id
    }) {
      mahasiswa {
        id
      }
    }
  }`
