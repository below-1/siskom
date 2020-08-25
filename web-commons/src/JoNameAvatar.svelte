<script>
  import colors_map from './utils/colors_map.js';

  const colors = ['blue', 'indigo', 'red', 'pink', 'teal', 'orange'];

  function split_name (name) {
    if (!name) return '';
    const ns = name.split(' ');
    return ns.map(n => n[0]).map(n => n.toUpperCase()).join('');
  }

  function random_color () {
    return colors[Math.floor(Math.random() * colors.length)]
  }

  function get_color (name) {
    if (initials) {
      if (colors_map.has(name)) {
        return colors_map.get(name);
      } else {
        const color = random_color();
        colors_map.set(name, color);
        return color;
      }
    }
    return colors[0];
  }

  // Props
  export let name;
  export let cls = '';
  export let size = 'base';

  // derived state
  $: initials = split_name(name);
  $: color = get_color(name);
  $: color_class = `bg-${color}-800`;
  $: classes = `${color_class} flex items-center justify-center text-white font-bold p-2 text-${size} ${cls}`;
</script>

<div class={classes}>
  {initials}
</div>
