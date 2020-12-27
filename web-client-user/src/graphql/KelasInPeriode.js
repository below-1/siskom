import { gql } from '@apollo/client/core';

export default gql`
	query AllKelasInPeriode($idPeriode: Int!) {
	  periodeById(id: $idPeriode) {
	    kelas: kelasByIdPeriode {
	      nodes {
	        id
	        label
	        mk: mataKuliahByIdMk {
	          id
	          nama
	          sks
	          kode
	          tipeMk
	          scheduled
	        }
	      }
	    }
	  }
	}
`;