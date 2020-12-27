import { gql } from '@apollo/client/core';

export default gql`
	query SchedulesByIds($ids: [Int!]!) {
	  allScheduledKelas(
	  	filter: {
	  		idKelas: {
	  			in: $ids
	  		}
	  	}
	  ) {
	    nodes {
	      hariKul
	      waktuKul
	      kapasitas
	      ruangan
	      totalMenit
	      dosen: dosenByIdDosen {
	        id
	        nama
	        nip
	      }
	    }
	  }
	}

`