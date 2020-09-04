import { writable } from 'svelte/store';

export const user = writable(null);
export const periode = writable(null);
export const phase = writable(null);
export const mahasiswa = writable(null);
export const dosen = writable(null);

export { default as notification } from './notification';
export { default as warning } from './warning';