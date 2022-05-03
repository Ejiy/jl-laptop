<script>
	import Apps from './components/Apps.svelte';
	import Icons from './components/Icons.svelte'
	import Winmanager from './components/Winmanager.svelte'
	import axios from 'axios'
	import {fly} from 'svelte/transition'
	export let appdata = {}
	appdata = {
		config: 'test'
	}
	let active = false
	let toggleActive = () => {
		active = !active
	}

	let closeLaptop = () => {
		active = false
		axios.post('https://tnj-laptop/close', JSON.parse({}))
	}

	window.addEventListener('message', function (event) { 
		switch(event.data.type) {
			case 'toggle':
				toggleActive();
				break;
			case 'close':
				active = false
				break;
		}
	 })

	document.onkeydown = function (data) {
		if(data.repeat) return
		switch(data.key) {
			case "Escape":
				if (active) toggleActive();
				break;
			case "Backspace":
				if (active) toggleActive();
				break;
		}
	}
</script>
<div id="app">
	<button on:click={toggleActive}>SHEESH</button>
	{#if active}

		<div class="desktop" transition:fly="{{y: 1000, duration: 1000}}">
			<Icons/>
			<Apps appdata/>
			<Winmanager/>
		</div>
	{/if}
</div>


<style>
	.desktop {
		width: 90%;
		height: 90%;
		bottom: -40%;
		left: 50%;
		transform: translate(-50%, -50%);
		position: absolute;
		/* visibility: hidden; */
		background-image: url('/images/wp.jpg');
		background-color: rgb(41, 41, 41);
		border: 7px solid rgb(0, 0, 0);
		border-radius: 5px;
		background-size: cover;
		background-position: center;
		opacity: 1;
		transition: 1s;
		z-index: -1;
		/* animation: laptop_up forwards cubic-bezier(0.4, 0, 0.01, 1.17) 1s; */
	}

</style>