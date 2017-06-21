import Vue from 'vue';
import Component from 'vue-class-component';

import { MDCDialog, MDCDialogFoundation, util } from '@material/dialog';

@Component({ })
export default class LayoutDialog extends Vue {
	private dialog: MDCDialog;
	private question: string = '';
	private subquestion: string = '';
	private callback: () => void;

	private mounted (): void {
		this.dialog = new MDCDialog(document.querySelector('#dialog'));

		this.dialog.listen('MDCDialog:accept', () => this.callback());

		this.$store.watch((state) => state.dialog, (newVal) => {
			this.question = newVal.question;
			this.subquestion = newVal.subquestion;
			this.callback = newVal.cb;
			this.dialog.show();
		});
	}
}
