export default function ({ kapasitas, room }) {
  if (!room) return null
  if (room && kapasitas > room.kapasitas) 
    return `Jumlah peserta tidak boleh melebihi kapasitas ruangan. Maksimal ${room.kapasitas}`
  return null
}