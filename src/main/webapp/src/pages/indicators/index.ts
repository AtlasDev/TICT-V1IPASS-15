import Vue from 'vue';
import Component from 'vue-class-component';

@Component({ })
export default class Indicators extends Vue {
  private async mounted (): Promise<void> {
		this.$store.commit('setLoading', true);
    await this.$store.dispatch('getIndicators');
		this.$store.commit('setLoading', false);
  }
}
