import { gql } from '@apollo/client/core';

export default gql`
  query MataKuliahById($id: Int!) {
    mataKuliahById(id: $id) {
      id
      kode
      minSks
      nama
      openIn
      sks
      prefSchedule
      tipeMk
      scheduled
    }
  }
`
