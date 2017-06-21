import Vue from 'vue';
import Component from 'vue-class-component';

@Component({ })
export default class Staff extends Vue {
  private async mounted (): Promise<void> {
    this.$store.commit('setLoading', true);
    await this.$store.dispatch('getStaff');
		this.$store.commit('setLoading', false);
  }

  private longType (type: string): string {
    switch (type) {
      case('D'): return 'Directeur';
      case('T'): return 'Teamleider';
      case('I'): return 'Intern Begeleider';
      case('L'): return 'Leraar';
    }
  }
}
