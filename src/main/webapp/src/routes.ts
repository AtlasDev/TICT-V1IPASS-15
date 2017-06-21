import { RouteConfig } from 'vue-router';

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
	component: home,
}, {
	path: '/login',
	name: 'Login',
	component: login,
}, {
	path: '/indicators',
	name: 'Indicatoren',
	component: indicators,
}, {
	path: '/report/:reportId',
	name: 'Bekijken Raport',
	component: inspectReport,
}, {
	path: '/reports',
	name: 'Rapporten',
	component: reports,
	children: [{
		path: ':employee',
		name: 'Personeel Rapport',
		component: reports,
	}],
}, {
	path: '/staff',
	name: 'Personeel',
	component: staff,
}, {
	path: '*',
	name: '404 Not Found',
	component: notFound,
}];
