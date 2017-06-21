<template>
	<div>
		<div class="mdc-layout-grid__cell--span-6 mdc-card card">
		  <section class="mdc-card__supporting-text">
				<ul class="metaDisplay mdc-list">
					<li class="mdc-list-item">
						<span>ID:</span> #{{ report.id }}
					</li>
					<li class="mdc-list-item">
						<span>Naam</span>: {{ report.target.firstName }} {{ report.target.lastName }}
					</li>
					<li class="mdc-list-item">
						<span>Kijker</span>: {{ report.creator.firstName }} {{ report.creator.lastName }}
					</li>
					<li class="mdc-list-item">
						<span>Aangemaakt</span>: {{ timeAgo(new Date(report.createdAt)) }} geleden
					</li>
					<li class="mdc-list-item">
						<span>Laatst aangepast</span>: {{ timeAgo(new Date(report.updatedAt)) }} geleden
					</li>
					<li class="mdc-list-item">
						<span>Indicatoren</span>: {{ report.answers.length }} / {{ $store.state.unStrucIndicators.length }}
					</li>
					<li class="mdc-list-item">
						<span>Commentaar</span>: {{ report.comment }}
					</li>
				</ul>
			</section>
			<section class="mdc-card__primary">
		    <h1 class="mdc-card__title mdc-card__title--large">Metadata</h1>
		  </section>
		</div>
		<div class="mdc-layout-grid__cell--span-3 mdc-layout-grid__cell--span-12-phone mdc-card card">
			<section class="mdc-card__supporting-text">
				<canvas id="inspectReportRatioChart" width="400" height="400"></canvas>
			</section>
			<section class="mdc-card__primary">
		    <h1 class="mdc-card__title mdc-card__title--large">Goedkeuring vragen</h1>
		  </section>
		</div>
		<div class="mdc-layout-grid__cell--span-3 mdc-layout-grid__cell--span-12-phone mdc-card card">
			<section class="mdc-card__supporting-text">
				<canvas id="inspectReportBarChart" width="400" height="400"></canvas>
			</section>
			<section class="mdc-card__primary">
		    <h1 class="mdc-card__title mdc-card__title--large">Goedkeuring vragen per sectie</h1>
		  </section>
		</div>
		<div class="mdc-layout-grid__cell--span-12 mdc-list-group mdc-card">
			<section class="mdc-card__primary">
		    <h1 class="mdc-card__title mdc-card__title--large">Indicatoren</h1>
		  </section>
		  <section class="mdc-card__supporting-text">
				<table>
					<tr class="table-header">
						<th>Sectie</th>
						<th>Subsectie</th>
						<th>Indicator</th>
						<th>Behaald</th>
						<th>Commentaar</th>
					</tr>
					<tr v-for="answer in report.answers">
						<td>{{ getIndicator(answer.indicator).section }}</td>
						<td>{{ getIndicator(answer.indicator).subsection }}</td>
						<td>{{ getIndicator(answer.indicator).question }}</td>
						<td>{{ answer.rating ? 'Ja' : 'Nee' }}</td>
						<td>{{ answer.comment }}</td>
					</tr>
				</table>
			</section>
    </div>
	</div>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
