import Main from './components/index.svelte';
import './styles/index.css';

const app = new Main({
	target: document.body,
	props: {
		name: 'world'
	}
});

export default app;