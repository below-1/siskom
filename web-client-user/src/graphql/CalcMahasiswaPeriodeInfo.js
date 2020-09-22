import { gql } from '@apollo/client/core';

export default gql`
	query CalcMahasiswaPeriodeInfo($idMahasiswa: Int!) {
		calcMahasiswaPeriodeInfo(_idMahasiswa: $idMahasiswa) {
	    nodes {
	      id
	      semester
	      sks
	      sksd
	      sksn
	      tahun
	    }
	  }
	}
`
