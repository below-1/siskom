import { gql } from '@apollo/client/core';

export default gql`
  query ListKelas($idPeriode: Int!) {
    allKelas(filter: {idPeriode: {equalTo: $idPeriode}}) {
      nodes {
        nodeId
        label
        id
        mataKuliah: mataKuliahByIdMk {
          id
          kode
          nama
          tipeMk
        }
        schedule: scheduledKelaByIdKelas {
          dosen: dosenByIdDosen {
            id
            nama
            nip
          }
          kapasitas
          ruangan
          totalMenit
          waktuKul
          hariKul
        }
      }
    }
    allPeriodes {
      nodes {
        id
        tahun
        semester
      }
    }
  }
`