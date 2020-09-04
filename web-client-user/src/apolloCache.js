import { InMemoryCache, defaultDataIdFromObject } from '@apollo/client/core';
export default new InMemoryCache({
  dataIdFromObject: object => {
    switch (object.__typename) {
      // case 'MahasiswaKela': return `${object.idKelas}-${object.idMhs}`;
      default: return defaultDataIdFromObject(object); // fall back to default handling
    }
  }
})
