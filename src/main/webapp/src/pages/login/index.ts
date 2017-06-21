import Vue from 'vue';
import Component from 'vue-class-component';

import { MDCTextfield } from '@material/textfield';
import * as jwt from 'jwt-decode';

@Component({ })
export default class Login extends Vue {
  private usernameEl: Element;
  private passwordEl: Element;
  private usernameField: MDCTextfield;
  private passwordField: MDCTextfield;

  private errorMessage: string = '';
  private username: string = '';
  private password: string = '';

  private mounted (): void {
    this.usernameEl = document.querySelector('.login-username');
    this.passwordEl = document.querySelector('.login-password');
    this.usernameField = new MDCTextfield(this.usernameEl);
    this.passwordField = new MDCTextfield(this.passwordEl);
  }

  private login (): void {
    this.errorMessage = '';
    fetch(this.$store.state.api.basePath + '/auth', {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        username: this.username,
        password: this.password,
      }),
    })
		.then((res) => res.json())
    .then((json) => {
      if (json.error) return this.errorMessage = json.message;
      this.$store.commit('loginUser', { ...json, ...jwt(json.token) });
      this.$router.push('/');
    }).catch((e) => {
      this.errorMessage = 'Er is een netwerkfout opgetreden!';
      console.error(e);
    });
  }
}
