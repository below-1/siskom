<script type="text/javascript">
  export let value;
  export let placeholder = '';
  export let cls = '';

  $: classes = "bg-white border-gray-400 border p-2 py-1 text-sm font-semibold rounded " + cls;
</script>

<input
  bind:value={value}
  type="date"
  placeholder={placeholder}
  class={classes}
/>

