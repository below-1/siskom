import { gql } from '@apollo/client/core';
import apolloClient from 'siskom-web-user/apolloClient.js';
import {
  periode as periodeStore,
  phase as phaseStore,
  dosen as dosenStore,
  mahasiswa as mahasiswaStore,
  user as userStore
} from 'siskom-web-commons';

const GQL_CommonData = gql`
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
    dosen: currentDosen {
      id
      nama
      nip
      status
      sex
    }
    user: currentAppUser {
      id
      nodeId
      scopes
      targetId
      tipeUser
      username
    }
    mahasiswa: currentMahasiswa {
      id
      idPa
      nama
      nodeId
      nim
      sex
      status
      tahunMasuk
      pa: dosenByIdPa {
        id
        nama
        nip
        sex
        status
        nodeId
      }
    }
  }
`;

export default async function updateSessionData () {
  const result = await apolloClient.query({
    query: GQL_CommonData
  })
  const {
    dosen,
    user,
    mahasiswa,
    setting
  } = result.data;
  const {
    periode,
    phase
  } = setting;

  if (!phase) {
    throw new Error('empty phase');
  }
  if (!periode) {
    throw new Error('empty active periode'); 
  }

  periodeStore.set(periode);
  phaseStore.set(phase);
  dosenStore.set(dosen);
  mahasiswaStore.set(mahasiswa);
  userStore.set(user);
}
