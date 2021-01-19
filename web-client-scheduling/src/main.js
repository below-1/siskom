import App from './components/index.svelte';
import './styles.css';

const app = new App({
	target: document.body,
	props: {
		name: 'world'
	}
});

export default app;