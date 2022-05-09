<script>

import { fly } from "svelte/transition";
import Boosting from "./apps/Boosting.svelte";
import Icons from "./Icons.svelte";
import Notification from "./Notification.svelte";
import ShittyRightSide from "./ShittyRightSide.svelte";
import Winmanager from "./Winmanager.svelte";

const app = [
	{name: "boosting", component: Boosting},
]

let openApp = (app) => {
	console.log(app.detail)
}

let showRightside = false
let toggleRightside = () => {
    showRightside = !showRightside
}
</script>

<div class="desktop" transition:fly="{{y: 1000, duration: 1000}}">
    <Icons on:openApp={openApp}/>
	<svelte:component this={Boosting}/>
    <Notification/>
    <ShittyRightSide showRightside={showRightside}/>
    <Winmanager on:toggleRightside={toggleRightside}/>
</div>

<style>
    .desktop {
  		overflow: hidden;
		width: 90%;
		height: 90%;
		bottom: -40%;
		left: 50%;
		transform: translate(-50%, -50%);
		position: absolute;
		background-image: url('../images/wp2.jpg');
		background-color: rgb(41, 41, 41);
		border: 5px solid rgb(0, 0, 0);
		border-radius: 5px;
		background-size: cover;
		background-position: center;
		opacity: 1;
		transition: 1s;
		z-index: -1;
	}
</style>