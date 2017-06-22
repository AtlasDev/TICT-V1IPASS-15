import Vue from 'vue';
import Vuex from 'vuex';

import * as persisted from 'vuex-persistedstate';

Vue.use(Vuex);

export default new Vuex.Store({
  plugins: [
    persisted({
      paths: ['user', 'api'],
    }),
  ],
  state: {
    user: {
      isLoggedin: false,
      token: null,
      name: null,
      role: null,
      username: null,
      expireDate: null,
    },
		api: {
			basePath: '/api',
		},
    staff: [ ],
    unStrucIndicators: [ ],
    indicators: { },
    reports: [ ],
		sidebar: false,
		loading: false,
    dialog: { },
  },
  mutations: {
    setSidebar: (state, newState) => state.sidebar = newState,
    setLoading: (state, newState) => state.loading = newState,
    setStaff: (state, newState) => state.staff = newState,
    setIndicators: (state, newState) => state.indicators = newState,
    setUnstrucIndicators: (state, newState) => state.unStrucIndicators = newState,
    setReports: (state, newState) => state.reports = newState,
    addReport: (state, newState) => state.reports.push(newState),
		showDialog: (state, newState) => state.dialog = newState,
		deleteReport: (state, reportId) => state.reports = state.reports.filter((report) => report.id !== reportId),
    loginUser: (state, user) => {
			state.user = {
        isLoggedin: true,
        token: user.token,
        name: user.name,
        role: user.role,
        username: user.sub,
        expireDate: user.exp * 1000,
      };
    },
    logoutUser: (state) => {
      state.user = {
        isLoggedin: false,
        token: null,
        name: null,
        role: null,
        username: null,
        expireDate: null,
      };
      state.sidebar = false;
    },
  },
  getters: {
    userRole: (state) => {
      switch (state.user.role) {
        case ('D'): return 'Directeur';
        case ('T'): return 'Teamleider';
        case ('I'): return 'Intern Begeleider';
        case ('L'): return 'Leraar';
        default: return '';
      }
    },
		isLoggedin: (state) => {
			return state.user.isLoggedin && new Date(state.user.expireDate) > new Date();
		},
  },
	actions: {
		getStaff: async (store) => {
      if (store.state.staff.length > 0) return store.state.staff;
      const res = await fetch(store.state.api.basePath + '/member', {
        method: 'GET',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${ store.state.user.token }`,
        },
      });
      store.commit('setStaff', await res.json());
		},
    getIndicators: async (store) => {
			if (Object.keys(store.state.indicators).length !== 0) return store.state.indicators;
      const res = await fetch(store.state.api.basePath + '/indicator', {
        method: 'GET',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${ store.state.user.token }`,
        },
      });
      const json = await res.json();
			store.commit('setUnstrucIndicators', json);
      const indicators: {
        [key: string]: {
          [key: string]: {
            id: string,
            indicator: string,
          }[],
        },
      } = { };
      await json.forEach((ind) => {
        const exists = (
          typeof indicators[ind.section] !== 'undefined' &&
          typeof indicators[ind.section][ind.subsection] !== 'undefined'
        );
        const indicator = exists ? indicators[ind.section][ind.subsection] : [];
        indicator.push({
          id: ind.id,
          indicator: ind.question,
        });
        indicators[ind.section] = {
          ...indicators[ind.section],
          [ind.subsection]: indicator,
        };
      });
      store.commit('setIndicators', indicators);
    },
		getReports: async (store) => {
			if (store.state.reports.length > 0) return store.state.reports;
      const res = await fetch(store.state.api.basePath + '/report?extended=true', {
        method: 'GET',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${ store.state.user.token }`,
        },
      });
      store.commit('setReports', await res.json());
		},
	},
});
