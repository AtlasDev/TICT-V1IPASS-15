<template>
	<div>
		<div class="mdc-layout-grid__cell--span-12" v-for="( section, sectionTitle ) in $store.state.indicators">
			<div class="mdc-list-group mdc-card">
				<section class="mdc-card__primary">
			    <h1 class="mdc-card__title mdc-card__title--large">{{ sectionTitle }}</h1>
			  </section>
			  <section class="mdc-card__supporting-text">
					<div v-for="(subSection, subSectionTitle) in section">
						<h3 class="mdc-list-group__subheader">{{ subSectionTitle }}</h3>
						<ul class="mdc-list">
							<li class="mdc-list-item item" v-for="indicator in subSection">{{indicator.id}} - {{ indicator.indicator }}</li>
						</ul>
						<hr class="mdc-list-divider">
					</div>
				</section>
			</div>
    </div>
	</div>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
