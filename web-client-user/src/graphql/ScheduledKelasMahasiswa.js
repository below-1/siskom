import { gql } from '@apollo/client/core';

export default gql`
  query ScKelasMahasiswa($idMahasiswa: Int!, $idPeriode: Int!) {
    scheduledKelasMahasiswa(_idMahasiswa: $idMahasiswa, _idPeriode: $idPeriode) {
      nodes {
        idKelas,
        idMk,
        kodeMk,
        namaMk,
        idDosen,
        namaDosen,
        nipDosen,
        label,
        hariKul,
        waktuKul,
        totalMenit,
        ruangan
      }
    }
  }
`