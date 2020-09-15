import { gql } from '@apollo/client/core';

export default gql`
  query KelasMembers($idKelas: Int!) {
    schedule: scheduledKelaByIdKelas(idKelas: $idKelas) {
      idDosen
    }
    members: kelasScheduleMembers(_idKelas: $idKelas) {
      nodes {
        id
        idMhs
        idKelas
        nilai
        mahasiswa: mahasiswaByIdMhs {
          id
          nama
          nim
          sex
          tahunMasuk
          status
        }
      }
    }
  }
`
