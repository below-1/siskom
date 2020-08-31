import { gql } from '@apollo/client/core';

export const RequiredData = gql`
  query ScheduledRequiredData {
    allRooms {
      nodes {
        nama
        kapasitas
      }
    }
    allDosens {
      nodes {
        id
        nama
        nip
      }
    }
  }
`

export const CreateSchedule = gql`
  mutation CreateScheduledKelas(
    $payload: NewScheduledClassInput!
  ) {
    newScheduledClass(input: $payload) {
      integer
    }
  }
`

export const ClashCourse = gql`
  query ListClashCourses(
    $periodeId: Int!,
    $dosenId: Int!,
    $ruangan: String!,
    $totalMenit: Int!,
    $hariKul: Hari!,
    $waktuKul: Time!
  ) {
    listClashCourses(
      _idDosen: $dosenId, 
      _idPeriode: $periodeId, 
      _totalMenit: $totalMenit, 
      _ruangan: $ruangan, 
      _hariKul: $hariKul,
      _waktuKul: $waktuKul) {
      nodes {
        dosenId
        dosenNama
        hariKul
        id
        idMk
        idPeriode
        dosenNip
        kapasitas
        label
        mkKode
        mkNama
        ruangan
        tipeMk
        totalMenit
        waktuKul
      }
    }
  }
`