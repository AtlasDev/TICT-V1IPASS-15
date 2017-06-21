<template>
	<div>
		<div class="mdc-layout-grid__cell--span-0 mdc-layout-grid__cell--span-2-tablet mdc-layout-grid__cell--span-4-desktop"></div>
		<div class="mdc-card mdc-layout-grid__cell--span-12 mdc-layout-grid__cell--span-8-tablet mdc-layout-grid__cell--span-4-desktop">
			<form @submit.prevent="login">
			  <section class="mdc-card__primary">
			    <h1 class="mdc-card__title mdc-card__title--large">Leraar Volg Systeem</h1>
			    <h2 class="mdc-card__subtitle">ASVO Basisschool Amsterdam</h2>
			  </section>
			  <section class="mdc-card__supporting-text">
					<span class="error">{{ errorMessage }}</span>
					<div class="mdc-textfield mdc-textfield--fullwidth login-username">
						<input type="email" id="username" class="mdc-textfield__input" required minlength=6 v-model="username">
						<label for="username" class="mdc-textfield__label">Gebruikersnaam</label>
					</div>
					<div class="mdc-textfield mdc-textfield--fullwidth login-password">
					  <input type="password" id="password" class="mdc-textfield__input" required minlength=6 v-model="password">
					  <label for="password" class="mdc-textfield__label">Wachtwoord</label>
					</div>
			  </section>
			  <section class="mdc-card__actions">
			    <button class="mdc-button mdc-card__action">Log in</button>
			  </section>
			</form>
		</div>
		<div class="mdc-layout-grid__cell--span-0 mdc-layout-grid__cell--span-2-tablet mdc-layout-grid__cell--span-4-desktop"></div>
	</div>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
