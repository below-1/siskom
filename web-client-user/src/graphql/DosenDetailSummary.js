import { gql } from '@apollo/client/core';

export default gql`
  query DetailDosen($id: Int!, $idPeriode: Int!) {
    bimbinganPa: allMahasiswas (
      first: 5,
      filter: {
        and: { 
          idPa: { equalTo: $id },
          status: { equalTo: AKTIF }
        }
      }
    ) {
      nodes {
        nodeId
        id
        nama
        nim
        sex
      }
    }

    totalActivePa: totalMahasiswaActivePaDosen (_idDosen: $id) 

    schedule: scheduleOfDosen(_idPeriode: $idPeriode, _idDosen: $id, first: 5) {
      total: totalCount
      nodes {
        idKelas
        nodeId
        kapasitas
        hariKul
        ruangan
        waktuKul
        totalMenit
        kelas: kelaByIdKelas {
          label
          mk: mataKuliahByIdMk {
            kode
            nama
            tipeMk
          }
        }
      }
    }
  }
`