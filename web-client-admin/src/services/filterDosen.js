export default function ({ keywordDosen, allDosens }) {
  if (!allDosens || allDosens.length == 0) return [];
  const keywordUpper = keywordDosen.toUpperCase();
  const items = allDosens.filter(d => {
    const nama = d.nama.toUpperCase();
    if (nama.includes(keywordUpper)) return true;
    const nip = d.nip.toUpperCase();
    if (nip.includes(keywordUpper)) return true;
    return false;
  }).slice(0, 5);
  return items;
}