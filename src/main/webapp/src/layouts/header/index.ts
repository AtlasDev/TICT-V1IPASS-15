import Vue from 'vue';
import Component from 'vue-class-component';

@Component({ })
export default class LayoutHeader extends Vue {
	private toggleMenu (): void {
		this.$store.commit('setSidebar', !this.$store.state.sidebar);
	}
}
