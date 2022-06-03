<script lang="ts">
  import { fly } from "svelte/transition";
  import Icons from "./Icons.svelte";
  import Notification from "./Notification.svelte";
  import ShittyRightSide from "./RightSide.svelte";
  import Winmanager from "./Winmanager.svelte";
  import { apps, openApp, openedAppStore } from "../store/desktop";
  import { cubicIn, cubicOut } from "svelte/easing";

  // APP
  import Boosting from "./apps/Boosting.svelte";
  import Browser from "./apps/Browser.svelte";

  // Register your app component here

  let registeredApp: any = {
    browser: Browser,
    boosting: Boosting,
  };

  let getComponent = (app: string) => {
    return registeredApp[app];
  };

  let handleOpenApp = (name: any) => {
    let filtered = $apps.filter((app) => app.name === name.detail);
    if (filtered.length > 0) {
      if (getComponent(filtered[0].name) !== undefined) {
        let data = {
          name: filtered[0].name,
          component: getComponent(filtered[0].name),
        };
        openApp(data);
      }
    }
  };

  $: {
    console.log("APPSTORE", $openedAppStore);
  }

  let showRightside = false;
  let toggleRightside = () => {
    showRightside = !showRightside;
  };
</script>

<div
  class="desktop"
  in:fly={{ y: 1000, duration: 1000, easing: cubicOut }}
  out:fly={{ y: 1000, duration: 500, easing: cubicIn }}
>
  <Icons on:openApp={handleOpenApp} />
  {#each $openedAppStore as app, index (app.name)}
    <svelte:component this={app.component} />
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
