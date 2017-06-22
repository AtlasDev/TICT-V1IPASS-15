<template>
	<div>
		<div class="mdc-layout-grid__cell--span-6 mdc-card card">
			<section class="mdc-card__supporting-text">
				<div class="mdc-select employeeSelect" role="listbox" tabindex="0">
					<span class="mdc-select__selected-text">Kies een leerkracht</span>
					<div class="mdc-simple-menu mdc-select__menu">
						<ul class="mdc-list mdc-simple-menu__items">
							<li class="mdc-list-item" role="option" :id="employee.id" tabindex="0" v-for="employee in $store.state.staff">
								{{ employee.firstName }} {{ employee.lastName }}
							</li>
						</ul>
					</div>
				</div>
				<div class="mdc-textfield mdc-textfield--fullwidth comment">
				  <input type="text" id="comment" class="mdc-textfield__input" v-model="comment">
				  <label class="mdc-textfield__label" for="comment">Commentaar</label>
				</div>
			</section>
			<section class="mdc-card__primary">
				<h1 class="mdc-card__title mdc-card__title--large">Nieuw Rapport</h1>
			</section>
		</div>
		<div class="mdc-layout-grid__cell--span-3 mdc-card card">
			<section class="mdc-card__supporting-text">
				<canvas id="addReportRatioChart"></canvas>
			</section>
			<section class="mdc-card__primary">
		    <h1 class="mdc-card__title mdc-card__title--large">Score vragen</h1>
		  </section>
		</div>
		<div class="mdc-layout-grid__cell--span-3 mdc-card card">
			<section class="mdc-card__supporting-text">
				<canvas id="addReportFilledChart"></canvas>
			</section>
			<section class="mdc-card__primary">
		    <h1 class="mdc-card__title mdc-card__title--large">Ingevulde vragen</h1>
		  </section>
		</div>
		<div class="mdc-layout-grid__cell--span-12" v-for="( section, sectionTitle ) in $store.state.indicators">
			<div class="mdc-list-group mdc-card">
				<section class="mdc-card__primary">
			    <h1 class="mdc-card__title mdc-card__title--large">{{ sectionTitle }}</h1>
			  </section>
			  <section class="mdc-card__supporting-text" v-for="(subSection, subSectionTitle) in section">
					<h3 class="mdc-list-group__subheader">{{ subSectionTitle }}</h3>
					<ul class="mdc-list">
						<li class="mdc-list-item" v-for="indicator in subSection">
							<div class="mdc-radio" @click="radioHandler(indicator, 'V')">
								<input
									class="mdc-radio__native-control"
									type="radio"
									:id="'radio-' + indicator.id + '-1'"
									:name="'radio-' + indicator.id">
								<div class="mdc-radio__background">
									<div class="mdc-radio__outer-circle"></div>
									<div class="mdc-radio__inner-circle"></div>
								</div>
							</div>
							<label :for="'radio-' + indicator.id + '-1'">V</label>

							<div class="mdc-radio" @click="radioHandler(indicator, 'OV')">
								<input
									class="mdc-radio__native-control"
									type="radio"
									:id="'radio-' + indicator.id + '-2'"
									:name="'radio-' + indicator.id">
								<div class="mdc-radio__background">
									<div class="mdc-radio__outer-circle"></div>
									<div class="mdc-radio__inner-circle"></div>
								</div>
							</div>
							<label :for="'radio-' + indicator.id + '-2'">OV</label>

							<div class="mdc-radio" @click="radioHandler(indicator, 'NB')">
								<input
									class="mdc-radio__native-control"
									type="radio"
									:id="'radio-' + indicator.id + '-3'"
									:name="'radio-' + indicator.id">
								<div class="mdc-radio__background">
									<div class="mdc-radio__outer-circle"></div>
									<div class="mdc-radio__inner-circle"></div>
								</div>
							</div>
							<label :for="'radio-' + indicator.id + '-3'">NB</label>
							<div class="item">{{ indicator.indicator }}</div>
						</li>
					</ul>
					<hr class="mdc-list-divider">
				</section>
			</div>
		</div>
		<button
			class="mdc-button mdc-button--raised submit"
			@click="submit"
			:disabled="!comment || answersLength === 0 || teacher === 0">
			Opslaan
		</button>
	</div>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
