<template>
  <div id="container">
		<layout-dialog></layout-dialog>
    <layout-sidebar v-show="$store.state.user.isLoggedin"></layout-sidebar>
    <div id="main-content">
      <layout-header v-show="$store.state.user.isLoggedin"></layout-header>
			<div class="mdc-layout-grid">
    		<router-view class="mdc-layout-grid__inner"></router-view>
			</div>
    </div>
  </div>
</template>

<script lang="ts" src="./index.ts"></script>
<style src="../../../node_modules/@material/button/dist/mdc.button.css"></style>
<style src="../../../node_modules/@material/card/dist/mdc.card.css"></style>
<style src="../../../node_modules/@material/dialog/dist/mdc.dialog.css"></style>
<style src="../../../node_modules/@material/drawer/dist/mdc.drawer.css"></style>
<style src="../../../node_modules/@material/layout-grid/dist/mdc.layout-grid.css"></style>
<style src="../../../node_modules/@material/linear-progress/dist/mdc.linear-progress.css"></style>
<style src="../../../node_modules/@material/list/dist/mdc.list.css"></style>
<style src="../../../node_modules/@material/menu/dist/mdc.menu.css"></style>
<style src="../../../node_modules/@material/textfield/dist/mdc.textfield.css"></style>
<style src="../../../node_modules/@material/toolbar/dist/mdc.toolbar.css"></style>
<style src="./index.css"></style>
