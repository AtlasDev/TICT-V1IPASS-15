<template>
	<div>
		<header class="mdc-toolbar toolbar">
		  <div class="mdc-toolbar__row">
		    <section class="mdc-toolbar__section mdc-toolbar__section--align-start">
					<button class="material-icons mdc-toolbar__icon--menu menuButton" @click="toggleMenu">menu</button>
		      <span class="mdc-toolbar__title">{{ $route.name }} - Volgsysteem</span>
		    </section>
		  </div>
		</header>
		<div role="progressbar" class="mdc-linear-progress mdc-linear-progress--indeterminate" v-if="$store.state.loading">
			<div class="mdc-linear-progress__buffer"></div>
			<div class="mdc-linear-progress__bar mdc-linear-progress__primary-bar">
				<span class="mdc-linear-progress__bar-inner"></span>
			</div>
			<div class="mdc-linear-progress__bar mdc-linear-progress__secondary-bar">
				<span class="mdc-linear-progress__bar-inner"></span>
			</div>
		</div>
	</div>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
