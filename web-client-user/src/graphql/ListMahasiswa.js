import { gql } from '@apollo/client/core';

export default gql`
	query ListMahasiswa($keyword: String!, $tahunMasuk: ThAjar!, $take: Int!) {
	  allMahasiswas(
	    first: $take, 
	    filter: {
	      tahunMasuk: {equalTo: $tahunMasuk}, 
	      nama: {likeInsensitive: $keyword}
	    },
	    orderBy: NIM_ASC
	  ) {
	    nodes {
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
	    pageInfo {
	      hasNextPage
	      hasPreviousPage,
	      startCursor,
	      endCursor
	    }
	  }
	}

`