import { gql } from '@apollo/client/core';

export default gql`
  query KelasSchedule($idKelas: Int!) {
    schedule: scheduledKelaByIdKelas(idKelas: $idKelas) {
      idKelas
      kapasitas
      hariKul
      totalMenit
      waktuKul
      ruangan
      dosen: dosenByIdDosen {
        id
        nama
        nip
        sex
        status
      }
    }
  }

`