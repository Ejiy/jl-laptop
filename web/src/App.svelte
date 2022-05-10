<script>

	import axios from 'axios'
	import { onDestroy, onMount } from 'svelte';
	import Desktop from './components/Desktop.svelte';
	import { notifications } from "./store/notifications";
	let active = true
	let toggleActive = (boolean) => {
		active = boolean === undefined ? !active : boolean
	}
	let showRightside = false
	let closeLaptop = async() => {
		await axios.post('https://tnj-laptop/close', JSON.parse({}))
		active = false
	}
	// let addIcons = () => {
	// 	apps.update((currentdata) => {
	// 		let newvalue =   {
	// 		name: "taxi",
	// 		icon: "fa-solid fa-taxi",
	// 		text: "Taxi",
	// 		color: "#fff",
	// 		background: "#000",
	// 	}
	// 		return [newvalue, ...currentdata]
	// 	})
	// }

	onMount(() => {
		console.log('mounted')
	})


	let toggleRightside = (e) => {
		showRightside = e.detail
	}

	window.addEventListener('message', function (event) { 
		switch(event.data.type) {
			case 'open':
				toggleActive(true);
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

	function randomNotif() {
		let randommessage = [
			'The best part of marriage is animal crackers with peanut butter.',
			'Happiness can be found in the depths of chocolate pudding.',
			"There should have been a time and a place, but this wasn't it."
		]
		notifications.send(randommessage[Math.floor(Math.random() * randommessage.length)], 'browser', 2000)
	}
</script>

<main>
	<div id="app">
		<!-- <button on:click={toggleActive}>SHEESH</button>
		<button on:click={addIcons}>ADD ICONS</button>
		<button on:click={randomNotif}>Notif</button>
		<button on:click={
			() => console.log($oldNotifications)
		}>LOG</button> -->
		{#if active} 
			<Desktop/>
		{/if}
	</div>
</main>


<style>
	
</style>