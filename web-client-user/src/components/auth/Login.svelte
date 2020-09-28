<script>
  import { onMount } from 'svelte';
  import { get } from 'svelte/store';
  import { push as pushRoute } from 'svelte-spa-router';
  import client from 'siskom-web-user/apolloClient.js';
  import axios from 'siskom-web-user/services/axios.js';
  import isEmpty from 'validator/es/lib/isEmpty';
  import trim from 'validator/es/lib/trim';
  import {
    JoAsyncContent,
    JoInput,
    JoButton,
    allIsNull,
    user
  } from 'siskom-web-commons';
  import GQLLogin from 'siskom-web-user/graphql/Login.js';
  import GQLCurrentUser from 'siskom-web-user/graphql/CurrentUser.js';
  import 'siskom-web-user/styles/auth.css';

  let username = '';
  let password = '';
  let networkStatus = 'loading';
  $: errors = {
    username: isEmpty(username) ? 'Username tidak boleh kosong' : null,
    password: isEmpty(password) ? 'Password tidak boleh kosong' : null
  };
  $: invalid = !allIsNull(errors);

  function redirect (tipeUser) {
    switch (tipeUser) {
      case 'MAHASISWA':
        pushRoute('/app/me_mhs/info');
        break;
      case 'DOSEN':
        pushRoute('/app/me_dosen/info');
        break;
      case 'ADMIN':
        pushRoute('/admin');
        break;
      default:
        alert('terjadi kesalahan');
    }
  }

  function getCurrentUser () {
    return client.query({
      query: GQLCurrentUser,
      fetchPolicy: 'network-only'
    })
      .then(resp => {
        const user = resp.data.currentAppUser;
        if (!user) throw new Error('user is empty');
        return user;
      })
  }

  function login () {
    const payload = {
      username,
      password
    }
    networkStatus = 'loading';
    return axios.post('/auth/login', payload, { withCredentials: true })
      .then(resp => resp.data)
      .then(data => {
        console.log(data)
      })
      .catch(err => {
        networkStatus = 'error';
        console.log(err);
        throw err;
      })
  }

  function onLogin () {
    return login()
      .then(getCurrentUser)
      .catch(err => {
        console.log('fail to get current user');
        throw err;
      })
      .then(user => {
        redirect(user.tipeUser)
      })
      .catch(err => {
        console.log(err);
        alert('something is wrong');
      })
  }

  onMount(async () => {
    // Check current store
    let currentUser = get(user);

    // If fail check from server.
    if (!currentUser) {
      try {
        currentUser = await getCurrentUser();
      } catch (err) {
        console.log(err);
      }
      // if fail too, show login form
      if (!currentUser) {
        networkStatus = 'ready';
        return;
      } else {
        const { tipeUser } = currentUser;
        if (tipeUser != 'ADMIN'){
          networkStatus = 'ready';
          return;
        } else {
          pushRoute('/admin');
        }
      }
    } else {
      const { tipeUser } = currentUser;
      if (tipeUser != 'ADMIN'){
        networkStatus = 'ready';
        return;
      } else {
        pushRoute('/admin');
      }
    }
  });
</script>

<div class="h-screen">
  <JoAsyncContent networkStatus={networkStatus}>
    <div slot="ready" class="flex items-stretch h-screen" id="login">
      <div class="hidden md:block w-1/3 bg-blue-600">
      </div>
      <div class="w-full bg-gray-200 md:w-2/3 flex flex-col items-center justify-center">
        <div class="text-blue-800 font-semibold text-xl text-center mb-8 px-12">
          Sistem Informasi Akademik Ilmu Komputer
        </div>
        <div class="w-4/5 bg-white md:w-3/5 p-4 border border-gray-200 rounded text-gray-700 shadow-lg">
          <div class="text-2xl font-semibold text-center mb-4">Login</div>
          <div class="mb-4 flex flex-col">
            <label class="mb-2">Username</label>
            <JoInput id="login_username" bind:value={username} placeholder="username" />
          </div>
          <div class="mb-4 flex flex-col">
            <label class="mb-2">Password</label>
            <input 
              id="login_password"
              bind:value={password}
              type="password" 
              placeholder="password" 
              class="border rounded border-gray-300 px-2" />
          </div>
          <div class="flex flex-col">
            <button 
              id="login_submit"
              disabled={invalid}
              on:click={onLogin}
              class="appearance-none p-2 bg-blue-600 text-white font-medium disabled:opacity-50"
            >Masuk</button>
          </div>
        </div>
      </div>
    </div>
  </JoAsyncContent>
</div>