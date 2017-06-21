import Vue from 'vue';
import Component from 'vue-class-component';

@Component({ })
export default class Reports extends Vue {
  private async mounted (): Promise<void> {
		this.$store.commit('setLoading', true);
    await this.$store.dispatch('getReports');
    await this.$store.dispatch('getIndicators');
		this.$store.commit('setLoading', false);
  }

  private createShortName (user: any): string {
    return user.firstName[0] + '. ' + user.lastName;
  }

  private filterReports () {
    return this.$store.state.reports.filter((report) => {
      return (!this.$route.params.employee) || (this.$route.params.employee.toString() === report.target.id.toString());
    });
  }

	private deleteReport (report) {
    this.$store.commit('showDialog', {
      question: `Verwijder rapport #${ report.id }?`,
      subquestion: 'Dit zal het rapport permanent verwijderen.',
      cb: () => {
        fetch(`${ this.$store.state.api.basePath }/report/${ report.id }`, {
          method: 'DELETE',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${ this.$store.state.user.token }`,
          },
        })
    		.then((res) => res.json())
        .then((json) => {
          if (json.error) return console.log('Failed to delete report.', json);
          this.$store.commit('deleteReport', report.id);
        }).catch((e) => {
          console.error('Network error!', e);
        });
      },
    });
	}

  private timeAgo (inputDate: Date): string {
    const seconds = Math.floor((new Date().getTime() - inputDate.getTime()) / 1000);

    const years = Math.floor(seconds / 31536000);
    if (years > 1) return years + " jaar";
    const months = Math.floor(seconds / 2592000);
    if (months > 1) return months + " maanden";
    const days = Math.floor(seconds / 86400);
    if (days > 1) return days + " dagen";
    const hours = Math.floor(seconds / 3600);
    if (hours > 1) return hours + " uur";
    const minutes = Math.floor(seconds / 60);
    if (minutes > 1) return minutes + " minuten";
    return Math.floor(seconds) + " seconden";
  }
}
