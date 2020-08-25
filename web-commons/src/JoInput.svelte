<script>
  export let value;
  export let placeholder = '';
  export let cls = '';
  export let id = undefined;

  $: classes = "bg-white border-gray-400 border p-2 py-1 text-sm font-semibold rounded " + cls;
</script>

<input
  bind:value={value}
  type="text"
  placeholder={placeholder}
  class={classes}
  {id}
/>

