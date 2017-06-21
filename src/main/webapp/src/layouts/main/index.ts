import Vue from 'vue';
import Component from 'vue-class-component';
import * as router from 'vue-router';

import LayoutDialog from '../dialog/index.vue';
import LayoutHeader from '../header/index.vue';
import LayoutSidebar from '../sidebar/index.vue';

import * as jwt from 'jwt-decode';

@Component({
  components: {
		'layout-dialog': LayoutDialog,
    'layout-header': LayoutHeader,
    'layout-sidebar': LayoutSidebar,
  },
})
export default class LayoutMain extends Vue {
	private mounted (): void {
    const user = this.$store.state.user;
    if (this.$store.getters.isLoggedin && this.$route.name === 'Login') {
      this.$router.push('/');
    } else if (!this.$store.getters.isLoggedin && this.$route.name !== 'Login') {
      this.$store.commit('logoutUser');
      this.$router.push('/login');
    }
		this.$router.beforeEach(this.routerGuard);
    setInterval(this.renewSession, 1200000);
    this.renewSession();
	}

  private routerGuard (to, from, next): router.NavigationGuard {
    if (this.$store.getters.isLoggedin && to.name === 'Login') {
      return next(false);
    } else if (!this.$store.getters.isLoggedin && (to.name !== 'Login' && to.name !== '404 Not Found')) {
      return next('/login');
    }
    return next();
  }

  private renewSession (): void {
		if (!this.$store.getters.isLoggedin) return;
    fetch(this.$store.state.api.basePath + '/auth/refresh', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${this.$store.state.user.token}`,
      },
    }).then((res) => res.json())
    .then((json) => {
      if (json.error) return console.error('Failed to renew session!', json);
      this.$store.commit('loginUser', { ...json, ...jwt(json.token) });
    }).catch((e) => {
      console.error('Failed to renew session!', e);
    });
  }
}
