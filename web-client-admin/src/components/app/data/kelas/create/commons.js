export const PREFIX = 'siskom.admin.kelas.create'
export const FORM = 'siskom.admin.kelas.create.input'
export const CLASHES = 'siskom.admin.kelas.create.clashes'

export function set_input_payload (payload) {
  localStorage.setItem(`${PREFIX}.input`, JSON.stringify(payload));
}

export function get_input_payload () {
  const raw = localStorage.getItem(`${PREFIX}.input`);
  if (raw) return JSON.parse(raw);
  return null;
}

export class ClashError extends Error {
  constructor (clashes) {
    super('terdapat tabrakan dosen atau ruangan')
    this.name = 'ClashError'
    this.clashes = clashes
  }
}
