import { gql } from '@apollo/client/core';

export default gql`
  query KelasDetail ($id: Int!) {

    kelas: kelaById(id: $id) {
      id
      label
      periode: periodeByIdPeriode {
        id
        semester
        tahun
      }
      mk: mataKuliahByIdMk {
        id
        kode
        nama
        scheduled
      }
    }

    schedule: scheduledKelaByIdKelas(idKelas: $id) {
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