export default function (item) {
  let kode;
  if (item.tipeMk == 'UMUM') {
    kode = 'MPK';
  } else if (item.tipeMk == 'WAJIB' || item.tipeMk == 'PILIHAN') {
    kode = 'STKOM';
  } else {
    throw new Error(`unknown tipeMk = ${item.tipeMk}`);
  }

  return {
    ...item,
    openIn: item.openIn == 'ALL' ? 'semua semester' : item.openIn.toLowerCase(),
    tipeMk: item.tipeMk.toLowerCase(),
    kode: kode + ' ' + item.kode
  }
}
