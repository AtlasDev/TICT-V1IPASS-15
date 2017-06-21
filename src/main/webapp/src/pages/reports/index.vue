<template>
	<div>
		<div class="mdc-layout-grid__cell--span-12">
			<div class="mdc-list-group mdc-card">
				<section class="mdc-card__primary">
			    <h1 class="mdc-card__title mdc-card__title--large">Rapporten</h1>
			  </section>
			  <section class="mdc-card__supporting-text" v-if="filterReports().length > 0">
					<table>
						<tr class="table-header">
							<th>Naam</th>
							<th>Kijker</th>
							<th>Aangemaakt</th>
							<th>Laatst aangepast</th>
							<th>Indicatoren</th>
							<th>Commentaar</th>
							<th>Acties</th>
						</tr>
						<tr v-for="report in filterReports()">
							<td>{{ createShortName(report.target) }}</td>
							<td>{{ createShortName(report.creator) }}</td>
							<td>{{ timeAgo(new Date(report.createdAt)) }} geleden</td>
							<td>{{ timeAgo(new Date(report.updatedAt)) }} geleden</td>
							<td>{{ report.answers.length }} / {{ $store.state.unStrucIndicators.length }}</td>
							<td>{{ report.comment }}</td>
							<td>
			          <router-link
									class="mdc-button mdc-button--compact mdc-button--dense material-icons link"
									:to="{ name: 'Bekijken Raport', params: { reportId: report.id }}"
									title="Bekijken Raport">
									supervisor_account
			          </router-link>
								<button
									class="mdc-button mdc-button--compact mdc-button--dense material-icons link"
									title="Aanpassen">
									mode_edit
								</button>
								<button
									class="mdc-button mdc-button--compact mdc-button--dense material-icons link"
									title="Verwijderen"
									@click="deleteReport(report)">
									delete
								</button>
							</td>
						</tr>
					</table>
				</section>
				<section class="mdc-card__supporting-text" v-if="filterReports().length === 0">
					Geen rapporten gevonden.
				</section>
			</div>
    </div>
	</div>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
