export default function (keyword) {
  return (kelas) => {
    const nama = kelas.mataKuliah.nama.toLowerCase();
    if (nama.includes(keyword)) return true;
    const kode = kelas.mataKuliah.kode.toLowerCase();
    if (kode.includes(keyword)) return true;
    return false;
  }
}