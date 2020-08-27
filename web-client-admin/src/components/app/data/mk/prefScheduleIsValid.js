export default function prefScheduleIsValid (prefSchedule, openIn) {
  if (isNaN(prefSchedule)) {
    return 'Semester Mata Kuliah tidak valid';
  }
  if (prefSchedule > 14 && prefSchedule < 1) {
    return 'Semester Mata Kuliah harus lebih dari 1 dan kurang dari 14';
  }
  if (openIn == 'GANJIL') {
    if (prefSchedule % 2 == 0) return 'Harus Ganjil';
  } else if (openIn == 'GENAP') {
    if (prefSchedule % 2 != 0) return 'Harus Genap';
  }
  return null;
}