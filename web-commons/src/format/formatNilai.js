export default function formatNilai (nilai) {
  if (nilai >= 80.00) {
    return { huruf: 'A', angka: 4.0 }
  }
  else if (nilai >= 77.5) {
    return { huruf: 'A-', angka: 3.75 }
  }
  else if (nilai >= 75.0) {
    return { huruf: 'AB', angka: 3.5 }
  }
  else if (nilai >= 72.5) { 
    return { huruf: 'B+', angka: 3.25 }
  }
  else if (nilai >= 70.0) {
    return { huruf: 'B', angka: 3.0 }
  } 
  else if (nilai >= 67.5) {
    return { huruf: 'B-', angka: 2.75 }
  }
  else if (nilai >= 65.0) { 
    return { huruf: 'BC', angka: 2.5 }
  }
  else if (nilai >= 62.5) {
    return { huruf: 'C+', angka: 2.25 }
  }
  else if (nilai >= 60.0) { 
    return { huruf: 'C', angka: 2.0 }
  }
  else if (nilai >= 57.5) { 
    return {huruf: 'C-', angka: 1.75}
  }
  else if (nilai >= 55.0) { 
    return { huruf: 'CD', angka: 1.5 }
  }
  else if (nilai >= 52.5) { 
    return { huruf: 'D+', angka: 1.25 }
  }
  else if (nilai >= 50.0) { 
    return {huruf: 'D', angka: 1.0 }
  }
  else return { huruf: 'E', angka: 0 }
}