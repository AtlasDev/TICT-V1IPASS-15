import Vue from 'vue';
import VueRouter from 'vue-router';

import MainLayout from './layouts/main/index.vue';
import { routes } from './routes';
import store from './store';

Vue.use(VueRouter);

const app = new Vue({
	el: '#app',
	store,
	render (h) { return h(MainLayout); },
	router: new VueRouter({
		mode: 'history',
		routes,
	}),
});

if ('serviceWorker' in navigator) {
	navigator.serviceWorker.register('/dist/sw.js').catch((err: Error) => {
		console.error('Failed to register the service worker!', err);
	});
} else {
	console.warn('This web browser does not support ServiceWorkers, so not registering it.');
}

import './fonts.css';
