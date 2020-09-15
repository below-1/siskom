import { gql } from '@apollo/client/core';

export default gql`
  query Schedule($idPeriode: Int, $idDosen: Int!) {
    schedule: scheduleOfDosen(_idPeriode: $idPeriode, _idDosen: $idDosen) {
      nodes {
        hariKul
        idDosen
        kapasitas
        nodeId
        ruangan
        totalMenit
        waktuKul
        kelas: kelaByIdKelas {
          label
          id
          mk: mataKuliahByIdMk {
            id
            kode
            minSks
            nama
            nodeId
            openIn
            prefSchedule
            scheduled
            sks
            tipeMk
          }
          nodeId
        }
      }
    }
  }
`