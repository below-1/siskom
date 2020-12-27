import { gql } from '@apollo/client/core';

export default gql`
	query PassedMks($id: Int!) {
	  allMahasiswaKelas(
	    filter: {
	      idMhs: {
	        equalTo: $id
	      },
	      nilai: {
	        greaterThanOrEqualTo: 60
	      }
	    }
	  ) {
	    nodes {
	      kelas: kelaByIdKelas {
	        idMk
	      }
	    }
	  }
	}

`