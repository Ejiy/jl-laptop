<script lang="ts">
  import { fade } from "svelte/transition";
  import { cubicInOut, cubicOut } from "svelte/easing";
  import app from "../main";
  import { closeApp, openedAppStore } from "../store/desktop";

  let moving = false;
  let left = 200;
  let top = 150;
  export let appname: string;
  export let topdata = {
    title: "Unknown",
    color: "#fff",
  };

  function onMouseDown() {
    moving = true;
    $openedAppStore.push(
      $openedAppStore.splice(
        $openedAppStore.findIndex((r) => r.name === appname),
        1
      )[0]
    );
    openedAppStore.set($openedAppStore);
  }

  function onMouseMove(e: { movementX: number; movementY: number }) {
    if (moving) {
      left += e.movementX;
      top += e.movementY;
    }
  }

  function onMouseUp() {
    moving = false;
  }

  // function closeApp() {
  //   showapp = false;
  //   const filtered = $apps.filter((app) => app.name === appname);
  //   if (filtered.length > 0) {
  //     filtered[0].isopen = false;
  //   }
  //   apps.set($apps);
  // }
</script>

<div
  class="apps"
  style="left: {left}px; top: {top}px"
  in:fade|local={{ duration: 150, easing: cubicInOut }}
  out:fade|local={{ duration: 100 }}
>
  <div class="actual-app">
    <div
      class="top {moving ? 'ondrag' : ''}"
      on:mousedown={onMouseDown}
      style="background: {topdata.color};"
    >
      <div class="title">
        <span class="title-text">{topdata.title}</span>
      </div>
      <div class="controls">
        <div
          class="exit"
          on:click={() => {
            closeApp(appname);
          }}
        >
          <i
            class="fa-solid fa-circle-xmark"
            style="color: rgb(245, 105, 105); font-size: 15px;"
          />
        </div>
      </div>
    </div>
    <slot />
  </div>
</div>
<svelte:window on:mouseup={onMouseUp} on:mousemove={onMouseMove} />

<style>
  .title-text {
    font-size: 15px;
    font-weight: bold;
    font-family: "Segoe UI", sans-serif;
  }
  .apps {
    border-radius: 6px;
    position: absolute;
    /* top: 50%;
        left: 50%; */
    transform: translate(-50px, -50px);
    width: 80%;
    height: 80%;
    overflow-y: hidden;
  }

  .ondrag {
    cursor: move;
  }
  .actual-app {
    width: 100%;
    height: 100%;
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    background: rgba(50, 48, 60, 0.978);
  }

  .top {
    position: sticky;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 15px;
    width: 100%;
    height: 30px;
    backdrop-filter: blur(10px);
  }

  .exit {
    width: max-content;
    height: max-content;
    cursor: pointer;
  }
</style>
