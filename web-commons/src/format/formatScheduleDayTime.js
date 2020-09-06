import formatDay from './formatDay.js';
import parse from 'date-fns/parse';
import add from 'date-fns/add';
import format from 'date-fns/format';

export default function ({ hari, jam, totalMenit }) {
  const t1 = parse(jam, 'kk:mm:ss', new Date())
  const t2 = add(t1, {
    minutes: totalMenit
  })
  const s1 = format(t1, 'kk:mm')
  const s2 = format(t2, 'kk:mm')

  return `${formatDay(hari)}, ${s1} - ${s2}`
}
