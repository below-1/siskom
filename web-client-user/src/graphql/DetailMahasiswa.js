import { gql } from '@apollo/client/core';

export default gql`
  query DetailMahasiswa($id: Int!) {
    mahasiswaById (id: $id) {
      biodata
      id
      pa: dosenByIdPa {
        id
        nama
        nip
      }
      nama
      nim
      sex
      tahunMasuk
    }

    attendedPeriode (_idMahasiswa: $id) {
      nodes {
        id
        tahun
        semester
      }
    }
  }
`