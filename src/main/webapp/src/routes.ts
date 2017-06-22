import { RouteConfig } from 'vue-router';

import addReport from './pages/addReport/index.vue';
import home from './pages/home/index.vue';
import indicators from './pages/indicators/index.vue';
import inspectReport from './pages/inspectReport/index.vue';
import login from './pages/login/index.vue';
import notFound from './pages/notfound/index.vue';
import reports from './pages/reports/index.vue';
import staff from './pages/staff/index.vue';

export const routes: RouteConfig[] = [{
	path: '/',
	name: 'Dashboard',
	component: (h) => h(home),
}, {
	path: '/login',
	name: 'Login',
	component: (h) => h(login),
}, {
	path: '/indicators',
	name: 'Indicatoren',
	component: (h) => h(indicators),
}, {
	path: '/report/add',
	name: 'Maak Raport',
	component: (h) => h(addReport),
}, {
	path: '/report/:reportId',
	name: 'Bekijken Raport',
	component: (h) => h(inspectReport),
}, {
	path: '/reports',
	name: 'Rapporten',
	component: (h) => h(reports),
	children: [{
		path: ':employee',
		name: 'Personeel Rapport',
		component: (h) => h(reports),
	}],
}, {
	path: '/staff',
	name: 'Personeel',
	component: (h) => h(staff),
}, {
	path: '*',
	name: '404 Not Found',
	component: (h) => h(notFound),
}];
