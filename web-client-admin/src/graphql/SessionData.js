import { gql } from '@apollo/client/core';

export default gql`
  query CommonData {
    setting: currentSetting {
      phase
      periode: currentPeriode {
        akhir
        awal
        id
        semester
        tahun
        ketua: dosenByIdKetua {
          id
          nama
          nip
        }
        sekretaris: dosenByIdSekretaris {
          id
          nama
          nip
        }
      }
    }
    user: currentAppUser {
      id
      nodeId
      scopes
      targetId
      tipeUser
      username
    }
  }
`;