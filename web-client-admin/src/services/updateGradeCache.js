import { gql } from '@apollo/client/core';

export default function ({ client, grade, id }) {
  const result = client.writeFragment({
    id,
    fragment: gql`
      fragment mahasiswaKelas on MahasiswaKela {
        nilai
        __typename
      }
    `,
    data: {
      nilai: grade,
      __typename: 'MahasiswaKela'
    }
  })
}
