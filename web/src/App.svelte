<script>
	import axios from 'axios'
	import { onDestroy, onMount } from 'svelte';
	import Desktop from './components/Desktop.svelte';
	import { notifications } from "./store/notifications";
	let active = false
	let toggleActive = (boolean) => {
		active = boolean === undefined ? !active : boolean
	}
	let showRightside = false
	let closeLaptop = () => {
		toggleActive(false)
		fetch('https://tnj-laptop/close', {
			method: 'POST',
			body: JSON.stringify({}),
			headers: {
				"Content-type": "application/json"
			}
		}).catch()
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
				toggleActive(event.data.status);
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
				closeLaptop();
				break;
			case "Backspace":
				closeLaptop();
				break;
			case "Enter":
				toggleActive(true);
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