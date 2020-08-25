<script type="text/javascript">
  export let value;
  export let placeholder = '';
  export let min = null;
  export let max = null;
  export let step = 1;
  export let rules = [];
  export let cls = '';

  $: classes = "bg-white border-gray-400 border p-2 py-1 text-sm font-semibold rounded " + cls;
</script>

<input
  bind:value={value}
  type='number'
  min={(min == undefined || min == null) ? undefined : min}
  max={max ? max : undefined}
  step={step}
  placeholder={placeholder}
  class={classes}
/>
