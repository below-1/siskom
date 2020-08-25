<script>
  export let options;
  export let value;
  export let label = 'label';
  export let size = 'sm';
  export let emptyLabel = 'pilih data'
  export let cls = '';
  $: classes = `flex items-center bg-white border border-gray-400 ${cls}`;

  $: fullOptions = [
    { label: emptyLabel, value: null },
    ...options
  ]
</script>

<div class={classes}>
  <div class={`bg-gray-100 px-2 text-${size} border-r border-gray-400`}>{label}</div>
  <select
    bind:value={value}
    class={`block bg-white px-4 py-1 pr-8 appearance-none rounded focus:outline-none flex-grow text-${size}`}
  >
    {#each fullOptions as option (option.value)}
      <option value={option.value}>{option.label}</option>
    {/each}
  </select>
</div>
