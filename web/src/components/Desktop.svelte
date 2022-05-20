<script>
  import { fly } from "svelte/transition";
  import Icons from "./Icons.svelte";
  import Notification from "./Notification.svelte";
  import ShittyRightSide from "./RightSide.svelte";
  import Winmanager from "./Winmanager.svelte";
  import { apps } from "../store/config";
  import { cubicIn, cubicOut } from "svelte/easing";

  // APP
  import Boosting from "./apps/Boosting.svelte";
  import Browser from "./apps/Browser.svelte";

  // Register your app component here
  let registeredApp = {
    browser: Browser,
    boosting: Boosting,
  };

  let openApp = (name) => {
    let filtered = $apps.filter((app) => app.name === name.detail);
    console.log(filtered[0]);
    if (filtered.length > 0) {
      filtered[0].isopen = true;
    }
    apps.set($apps);
  };

  let getApp = (name) => {
    const filtered = app.filter((app) => app.name === name);
    if (filtered.length > 0) {
      console.log(filtered[0].component);
    }
  };

  let showRightside = false;
  let toggleRightside = () => {
    showRightside = !showRightside;
  };

  function log() {
    console.log($apps);
  }
</script>

<div
  class="desktop"
  in:fly={{ y: 1000, duration: 1000, easing: cubicOut }}
  out:fly={{ y: 1000, duration: 500, easing: cubicIn }}
>
  <Icons on:openApp={openApp} />
  {#each $apps as app (app.name)}
    {#if app.isopen}
      {#if registeredApp[app.name]}
        <svelte:component this={registeredApp[app.name]} />
      {/if}
    {/if}
  {/each}
  <Notification />
  <ShittyRightSide {showRightside} />
  <Winmanager on:toggleRightside={toggleRightside} />
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
    background-image: url("../images/wp2.jpg");
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
