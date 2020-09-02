import { gql } from '@apollo/client/core';

export default gql`
  query AllPeriodes {
    allPeriodes {
      nodes {
        id
        akhir
        awal
        semester
        tahun
        ketua: dosenByIdKetua {
          id
          nama
        }
        sekretaris: dosenByIdSekretaris {
          id
          nama
        }
      }
    }
  }
`