import IoIosCube from 'svelte-icons/io/IoIosCube.svelte'
import IoIosContact from 'svelte-icons/io/IoIosContact.svelte'
import IoIosCalendar from 'svelte-icons/io/IoIosCalendar.svelte'
import FaCheckDouble from 'svelte-icons/fa/FaCheckDouble.svelte'
import FaFileExport from 'svelte-icons/fa/FaFileExport.svelte'
import FaFileImport from 'svelte-icons/fa/FaFileImport.svelte'

export const mahasiswa = [
  { header: true, label: 'ilkom' },
  { label: 'Info', path: '/#/app/me_mhs/info', icon: IoIosContact },
  { label: 'IPK', path: '/#/app/me_mhs/schedule', icon: IoIosCube },
  { label: 'Jadwal', path: '/#/app/me_mhs/schedule', icon: IoIosCalendar },
  { label: 'Transkrip Nilai', path: '/#/app/me_mhs/transkrip', icon: FaCheckDouble },
  { label: 'KRS', path: '/#/app/me_mhs/krs', icon: FaFileExport },
  { label: 'KHS', path: '/#/app/me_mhs/khs', icon: FaFileImport },
  { header: true, label: 'ilkom' },
  { label: 'Dosen', path: '/#/app/ilkom/dosens' },
  { label: 'Mata Kuliah', path: '/#/app/ilkom/mks' },
  { label: 'Kelas', path: '/#/app/ilkom/kelas' },
  { label: 'Mahasiswa', path: '/#/app/ilkom/mahasiswas' },
  { header: true, label: 'lainnya' },
  { label: 'Bantuan', path: '/#/app/etc/help' },
  { label: 'Logout', path: '/#/app/auth/logout' }
];

export const dosen = [
  { header: true, label: 'personal' },
  { label: 'Info', path: '/#/app/me_dosen/info' },
  { label: 'Jadwal', path: '/#/app/me_dosen/schedules' },
  { label: 'Bimbingan Akademik', path: '/#/app/me_dosen/pas' },
  { header: true, label: 'ilkom' },
  { label: 'Kelas', path: '/#/app/ilkom/kelas' },
  { label: 'Dosen', path: '/#/app/ilkom/dosens' },
  { label: 'Mata Kuliah', path: '/#/app/ilkom/mks' },
  { label: 'Mahasiswa', path: '/#/app/ilkom/mahasiswas' },
  { header: true, label: 'lainnya' },
  { label: 'Bantuan', path: '/#/app/etc/help' },
  { label: 'Logout', path: '/#/app/auth/logout' }
];