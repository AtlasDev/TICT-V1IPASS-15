import Vue from 'vue';
import Component from 'vue-class-component';

import { MDCSelect } from '@material/select';
import { MDCTextfield } from '@material/textfield';

import { Chart } from 'chart.js';

@Component({ })
export default class AddReport extends Vue {
	private commentField: MDCTextfield;
	private comment: string = '';
	private teachterField: MDCSelect;
	private teacher: number = 0;
	private answers: { [indicator: string]: IAnswer } = { };
	private ratioChart;
	private filledChart;
	private answersLength = 0;

  private async mounted (): Promise<void> {
		this.$store.commit('setLoading', true);
    await this.$store.dispatch('getIndicators');
    await this.$store.dispatch('getStaff');

    this.commentField = new MDCTextfield(document.querySelector('.comment'));
		this.teachterField = new MDCSelect(document.querySelector('.mdc-select'));
		this.teachterField.listen('MDCSelect:change', () => this.teacher = this.teachterField.value);
		this.createCharts();
		this.$store.commit('setLoading', false);
  }

	private createCharts (): void {
		const ratio = (document.getElementById('addReportRatioChart') as HTMLCanvasElement);
		this.ratioChart = new Chart(ratio.getContext('2d'), {
  		type: 'doughnut',
  		data: {
    		labels: ['Voldoende', 'Niet Voldoende'],
    		datasets: [{
      		data: [1, 1],
      		backgroundColor: [
            '#c6ff00',
        		'#f44336',
      		],
    		}],
  		},
      options: {
        responsive: true,
        legend: false,
      },
		});

		const filled = (document.getElementById('addReportFilledChart') as HTMLCanvasElement);
		this.filledChart = new Chart(filled.getContext('2d'), {
  		type: 'doughnut',
  		data: {
    		labels: ['Ingevuld', 'Niet Ingevuld'],
    		datasets: [{
      		data: [ Object.keys(this.answers).length, Object.keys(this.$store.state.unStrucIndicators).length ],
      		backgroundColor: [
            '#c6ff00',
        		'#f44336',
      		],
    		}],
  		},
      options: {
        responsive: true,
        legend: false,
      },
		});
	}

	private getRatio (): number[] {
		const res = [0, 0];
		for (const answer in this.answers) {
			if (!this.answers.hasOwnProperty(answer)) continue;
			this.answers[answer].rating ? res[0]++ : res[1]++;
		}
		return res;
	}

	private updateChart (): void {
		this.ratioChart.data.datasets = [{
			data: this.getRatio(),
			backgroundColor: [
				'#c6ff00',
				'#f44336',
			],
		}];
		this.ratioChart.update(150);

		this.filledChart.data.datasets = [{
			data: [ Object.keys(this.answers).length, Object.keys(this.$store.state.unStrucIndicators).length ],
			backgroundColor: [
				'#c6ff00',
				'#f44336',
			],
		}];
		this.filledChart.update(0);
	}

	private radioHandler (indicator, value): void {
		if (value === 'NB') {
			if (this.answers[indicator.id]) delete this.answers[indicator.id];
			this.updateChart();
			return;
		}
		this.answers[indicator.id] = {
			indicator,
			rating: (value === 'V') ? true : false,
		};
		this.updateChart();
		this.answersLength = Object.keys(this.answers).length;
	}

	private submit (): void {
		const formatAnswers = [];
		for (const answer in this.answers) {
			if (!this.answers.hasOwnProperty(answer)) continue;
			formatAnswers.push({
				rating: this.answers[answer].rating,
				indicator: this.answers[answer].indicator.id,
			});
		}
		fetch(this.$store.state.api.basePath + '/report', {
			method: 'POST',
			headers: {
				'Accept': 'application/json',
				'Content-Type': 'application/json',
				'Authorization': `Bearer ${ this.$store.state.user.token }`,
			},
			body: JSON.stringify({
				comment: this.comment,
				teacher: this.teacher,
				watcher: this.$store.state.user.username,
				answers: formatAnswers,
			}),
		})
		.then((res) => res.json())
		.then((json) => {
			if (json.error) return console.log(json.error);
			json.creator = this.$store.state.staff.find((employee) => employee.id === json.creator);
			json.target = this.$store.state.staff.find((employee) => employee.id === json.target);
			this.$store.commit('addReport', json);
			this.$router.push(`/reports`);
		}).catch((e) => {
			console.error(e);
		});
	}
}

interface IAnswer {
	indicator: any;
	rating: boolean;
	comment?: string;
}
