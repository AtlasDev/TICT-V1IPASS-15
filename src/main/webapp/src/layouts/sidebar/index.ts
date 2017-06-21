import Vue from 'vue';
import Component from 'vue-class-component';

import { MDCTemporaryDrawer } from '@material/drawer';
import { MDCSimpleMenu } from '@material/menu';

@Component({ })
export default class LayoutSidebar extends Vue {
  private drawerEl: Element;
  private drawer: MDCTemporaryDrawer;
	private menuEl: Element;
  private menu: MDCSimpleMenu;

  private mounted (): void {
    this.drawerEl = document.querySelector('.mdc-temporary-drawer');
    this.menuEl = document.querySelector('.drawerMenu');
    this.drawer = new MDCTemporaryDrawer(this.drawerEl);
    this.menu = new MDCSimpleMenu(this.menuEl);

    this.$store.watch((state) => state.sidebar, (newVal) => this.drawer.open = newVal);
    this.drawerEl.addEventListener('MDCTemporaryDrawer:close', () => this.$store.commit('setSidebar', false));
    this.$router.afterEach(() => this.$store.commit('setSidebar', false));
  }

  private openMenu (): void {
    this.menu.open = !this.menu.open;
  }

  private logout (): void {
    this.$store.commit('logoutUser');
    this.$router.push('/login');
  }

  private lock (): void {
    alert('ToDo: lock');
  }
}
