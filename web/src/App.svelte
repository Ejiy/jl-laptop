<script>

	import Apps from './shared/Apps.svelte';
	import Icons from './components/Icons.svelte'
	import Winmanager from './components/Winmanager.svelte'
	import Notification from './components/Notification.svelte';
	import axios from 'axios'
	import { fly } from 'svelte/transition'
	import ShittyRightSide from './components/ShittyRightSide.svelte';
	import { onDestroy, onMount } from 'svelte';
	import { apps } from './store/config'
import Desktop from './components/Desktop.svelte';
	export let appdata = {}
	appdata = {
		config: 'test'
	}
	let active = true
	let toggleActive = () => {
		active = !active
	}
	let showRightside = false
	let closeLaptop = async() => {
		await axios.post('https://tnj-laptop/close', JSON.parse({}))
		active = false
		
	}

	let addIcons = () => {
		apps.update((currentdata) => {
			let newvalue =   {
			name: "taxi",
			icon: "fa-solid fa-taxi",
			text: "Taxi",
			color: "#fff",
			background: "#000",
		}
			return [newvalue, ...currentdata]
		})
	}

	onMount(() => {
		console.log('mounted')
	})


	let toggleRightside = (e) => {
		showRightside = e.detail
	}

	window.addEventListener('message', function (event) { 
		switch(event.data.type) {
			case 'toggle':
				toggleActive();
				break;
			case 'close':
				closeLaptop()
				break;
		}
	 })

	 onDestroy(() => {
		 window.removeEventListener('message')
		 console.log('destroyed')
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
	<button on:click={addIcons}>ADD ICONS</button>
	<button>SHOWAPP</button>
	{#if active} 
		<Desktop/>
	{/if}
</div>

<style>
	

</style>