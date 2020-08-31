import { gql } from '@apollo/client/core';

export default gql`
  query ListMahasiswaKelas($idKelas: Int!) {
    allMahasiswaKelas(condition: { idKelas: $idKelas }) {
      nodes {
        idKelas
        idMhs
        nilai
        mahasiswa: mahasiswaByIdMhs {
          id
          nama
          nim
          tahunMasuk
        }
      }
    }
  }
`