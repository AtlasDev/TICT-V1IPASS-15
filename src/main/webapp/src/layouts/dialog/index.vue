<template>
	<aside id="dialog" class="mdc-dialog">
		<div class="mdc-dialog__surface">
			<header class="mdc-dialog__header">
				<h2 id="my-mdc-dialog-label" class="mdc-dialog__header__title">{{ question }}</h2>
			</header>
			<section id="my-mdc-dialog-description" class="mdc-dialog__body">
				{{ subquestion }}
			</section>
			<footer class="mdc-dialog__footer">
				<button type="button" class="mdc-button mdc-dialog__footer__button mdc-dialog__footer__button--cancel">Annuleren</button>
				<button type="button" class="mdc-button mdc-dialog__footer__button mdc-dialog__footer__button--accept">Okey</button>
			</footer>
		</div>
		<div class="mdc-dialog__backdrop"></div>
	</aside>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
