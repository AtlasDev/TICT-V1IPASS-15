import Vue from 'vue';
import Component from 'vue-class-component';

import { MDCTemporaryDrawer } from '@material/drawer';
import { MDCSimpleMenu } from '@material/menu';

import { Chart } from 'chart.js';

@Component({ })
export default class InspectReport extends Vue {
  private chart;
  private report = {
    creator: { },
    target: { },
    answers: [ ],
  };

  private async mounted (): Promise<void> {
		this.$store.commit('setLoading', true);
    await this.$store.dispatch('getReports');
    await this.$store.dispatch('getIndicators');
    this.report = this.$store.state.reports.find((report) => report.id = this.$route.params.reportId);
		this.createCharts();
		this.$store.commit('setLoading', false);
  }

	private createCharts (): void {
		this.chart = new Chart((document.getElementById('inspectReportChart') as HTMLCanvasElement).getContext('2d'), {
  		type: 'doughnut',
  		data: {
    		labels: ['Voldoende', 'Niet Voldoende'],
    		datasets: [{
      		data: this.report.answers.reduce((acc, answer) => {
            answer.rating ? acc[0]++ : acc[1]++;
            return acc;
          }, [0, 0]),
      		backgroundColor: [
            '#c6ff00',
        		'#f44336',
      		],
    		}],
  		},
		});
	}

  private getIndicator (id: string) {
    return this.$store.state.unStrucIndicators.find((indicator) => indicator.id === id);
  }

  private timeAgo (inputDate: Date): string {
    const seconds = Math.floor((new Date().getTime() - inputDate.getTime()) / 1000);

    const years = Math.floor(seconds / 31536000);
    if (years > 1) return years + ' jaar';
    const months = Math.floor(seconds / 2592000);
    if (months > 1) return months + ' maanden';
    const days = Math.floor(seconds / 86400);
    if (days > 1) return days + ' dagen';
    const hours = Math.floor(seconds / 3600);
    if (hours > 1) return hours + ' uur';
    const minutes = Math.floor(seconds / 60);
    if (minutes > 1) return minutes + ' minuten';
    return Math.floor(seconds) + ' seconden';
  }
}
