<script>
	import { foo } from 'siskom-web-admin/someGoofy.js';
	export let name;
	let message = foo;
</script>

<main>
	<h1 class="text-4xl font-black text-red-700">Hello {name}: {message}!</h1>
	<p>Visit the <a href="https://svelte.dev/tutorial">Svelte tutorial</a> to learn how to build Svelte apps.</p>
</main>
