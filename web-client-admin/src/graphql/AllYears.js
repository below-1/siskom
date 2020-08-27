import { gql } from '@apollo/client/core';

export default gql`
  query AllYears {
    allYears {
      nodes
    }
  }`;
