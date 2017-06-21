<template>
	<aside class="mdc-temporary-drawer">
    <nav class="mdc-temporary-drawer__drawer">
      <header class="mdc-temporary-drawer__header header">
        <div class="mdc-temporary-drawer__header-content header-content">
					<span class="subtitle">{{ $store.getters.userRole }}</span>
					<span class="title">
						{{ $store.state.user.name }}
						<div class="actions">
							<div class="mdc-menu-anchor">
								<i class="material-icons" aria-hidden="true" title="Acties" @click="openMenu">more_vert</i>
								<div class="mdc-simple-menu drawerMenu">
									<ul class="mdc-simple-menu__items mdc-list" role="menu" aria-hidden="true">
										<li class="mdc-list-item" role="menuitem" tabindex="0" @click="logout">
											<i class="material-icons" aria-hidden="true" title="">power_settings_new</i>
											Uitloggen
										</li>
										<li class="mdc-list-item" role="menuitem" tabindex="0" @click="lock">
											<i class="material-icons" aria-hidden="true" title="">lock_outline</i>
											Vergrendelen
										</li>
									</ul>
								</div>
							</div>
						</div>
					</span>
					<img src="https://1.gravatar.com/avatar/101b7ffe22f67913a428e5ec1072549a?s=500"></img>
        </div>
      </header>

      <nav class="mdc-temporary-drawer__content mdc-list-group">
        <div id="icon-with-text-demo" class="mdc-list">
          <router-link
						class="mdc-list-item"
						:class="{ 'mdc-temporary-drawer--selected': $route.path === '/' }"
						to="/">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">dashboard</i>Dashboard
          </router-link>
          <router-link
						class="mdc-list-item"
						:class="{ 'mdc-temporary-drawer--selected': $route.path === '/reports' }"
						to="/reports">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">assignment</i>Rapporten
          </router-link>
          <router-link
						class="mdc-list-item"
						:class="{ 'mdc-temporary-drawer--selected': $route.path === '/indicators' }"
						to="/indicators">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">question_answer</i>Indicatoren
          </router-link>
          <router-link
						class="mdc-list-item"
						:class="{ 'mdc-temporary-drawer--selected':$route.path === '/staff' }"
						v-if="['D', 'T', 'I'].indexOf($store.state.user.role) >= 0"
						to="/staff">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">supervisor_account</i>Personeel
          </router-link>
        </div>

        <hr class="mdc-list-divider">

        <div class="mdc-list">
          <a class="mdc-list-item" target="_blank" href="https://opensource.org/licenses/MIT">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">description</i>MIT License
          </a>
          <a class="mdc-list-item" target="_blank" href="https://github.com/AtlasDev/TICT-V1IPASS-15">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">code</i>GitHub
          </a>
          <a class="mdc-list-item" target="_blank" href="https://atlasdev.nl">
            <i class="material-icons mdc-list-item__start-detail" aria-hidden="true">cloud</i>Website
          </a>
        </div>
      </nav>
    </nav>
  </aside>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="./index.css" scoped></style>
