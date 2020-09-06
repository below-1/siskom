<script>
  import { getContext } from 'svelte';
  import apolloClient from 'siskom-web-user/apolloClient.js';
  import GQLDetailMahasiswa from 'siskom-web-user/graphql/DetailMahasiswa.js';
  import {
    JoAsyncContent,
    mahasiswa as globalMahasiswa, 
    user 
  } from 'siskom-web-commons';
  import * as context_key from './context.js';

  const mahasiswa = getContext(context_key.mahasiswa);
  const attendedPeriode = getContext(context_key.attendedPeriode);
  const prefix = getContext(context_key.prefix);

  function userCanSeeDetail ({ user, mahasiswa, globalMahasiswa }) {
    if (!user) return false;
    if (!globalMahasiswa) return false;
    if (!mahasiswa) return false;

    if (user.tipeUser == 'admin' || user.tipeUser == 'dosen') return true;

    if (globalMahasiswa.id == mahasiswa.id) return true;

    return false;
  }

  $: networkStatus = $mahasiswa.id ? 'success' : 'loading';
  $: canSeeDetail = userCanSeeDetail({
    user: $user,
    mahasiswa: $mahasiswa,
    globalMahasiswa: $globalMahasiswa
  });

</script>

<JoAsyncContent {networkStatus}>
  <div slot="success">

    <div class="bg-white mt-6 py-4 px-4 md:w-2/3">
      <div id="mhs_section_title" class="text-center text-lg font-bold">Informasi Umum</div>
    </div>

    <div class="px-4 mb-6 bg-white md:w-2/3 font-semibold">
      <div class="flex items-center justify-between py-3 border-b border-gray-300">
        <span>Nama</span>
        <span>{$mahasiswa.nama}</span>
      </div>
      <div class="flex items-center justify-between py-3 border-b border-gray-300">
        <span>NIM</span>
        <span>{$mahasiswa.nim}</span>
      </div>
      <div class="flex items-center justify-between py-3 border-b border-gray-300">
        <span>Jenis Kelamin</span>
        <span>{$mahasiswa.sex}</span>
      </div>
      <div class="flex items-center justify-between py-3 border-b border-gray-300">
        <span>Tahun Masuk</span>
        <span>{$mahasiswa.tahunMasuk}</span>
      </div>
      <div class="flex items-center justify-between py-3 border-b border-gray-300">
        <span>Semester</span>
        <span>{$attendedPeriode.length}</span>
      </div>
      <div class="flex items-center justify-between py-3 border-b border-gray-300">
        <span>Dosen Pa</span>
        <span>{$mahasiswa.pa.nama}</span>
      </div>
    </div>

    {#if canSeeDetail}
      <div class="bg-white mt-6 py-4 px-4">
        <div class="text-center text-lg font-bold">Link</div>
      </div>

      <ul class="bg-white px-4 mb-6">
        <li>
          <a 
            href={`/#${prefix}/schedule`}
            class="py-2 px-2 mb-2 flex items-center rounded bg-gray-200 shadow"
          >
            <div 
              class="w-1/5 h-12 bg-blue-800 text-white font-bold text-lg flex items-center justify-center mr-4"
            >
              JD
            </div>
            <p class="w-4/5">Menampilkan jadwal perkuliahan untuk mahasiswa <span>{$mahasiswa.nama}</span></p>
          </a>
        </li>
        <li>
          <a 
            href={`/#${prefix}/transkrip`}
            class="py-2 px-2 mb-2 flex items-center rounded bg-gray-200 shadow"
          >
            <div 
              class="w-1/5 h-12 bg-teal-800 text-white font-bold text-lg flex items-center justify-center mr-4"
            >
              TR
            </div>
            <p class="w-4/5">Menampilkan transkrip nilai untuk mahasiswa <span>{$mahasiswa.nama}</span></p>
          </a>
        </li>
        <li>
          <a 
            href={`/#${prefix}/krs`}
            class="py-2 px-2 mb-2 flex items-center rounded bg-gray-200 shadow"
          >
            <div 
              class="w-1/5 h-12 bg-pink-800 text-white font-bold text-lg flex items-center justify-center mr-4"
            >
              KRS
            </div>
            <p class="w-4/5">Menampilkan KRS untuk mahasiswa <span>{$mahasiswa.nama}</span></p>
          </a>
        </li>
        <li>
          <a 
            href={`/#${prefix}/khs`}
            class="py-2 px-2 mb-2 flex items-center rounded bg-gray-200 shadow"
          >
            <div 
              class="w-1/5 h-12 bg-green-800 text-white font-bold text-lg flex items-center justify-center mr-4"
            >
              KHS
            </div>
            <p class="w-4/5">Menampilkan KHS untuk mahasiswa <span>{$mahasiswa.nama}</span></p>
          </a>
        </li>
      </ul>
    {/if}
  </div>
</JoAsyncContent>
