<template>
	<div>
		<div class="mdc-layout-grid__cell--span-12">
			<div class="mdc-list-group mdc-card">
				<section class="mdc-card__primary">
			    <h1 class="mdc-card__title mdc-card__title--large">Alle medewerkers</h1>
			  </section>
			  <section class="mdc-card__supporting-text">
					<ul class="mdc-list">
						<li class="mdc-list-item item" v-for="employee in $store.state.staff">
							<img class="mdc-list-item__start-detail" src="https://1.gravatar.com/avatar/101b7ffe22f67913a428e5ec1072549a?s=500"></img>
							<div class="content">
								<div class="title">{{ employee.firstName }} {{ employee.lastName }}</div>
								<div class="subtitle">{{ longType(employee.type) }} - {{ employee.email }}</div>
							</div>
							<router-link
								class="mdc-button mdc-button--compact mdc-button--dense material-icons right"
								title="Aanpassen"
								:to="{ name: 'Personeel Rapport', params: { employee: employee.id }}">
								remove_red_eye
							</router-link>
						</li>
					</ul>
				</section>
			</div>
    </div>
	</div>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
