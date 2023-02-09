<script lang="ts">
  import { fade } from "svelte/transition";
  import { cubicInOut } from "svelte/easing";
  import { closeApp, openedApps } from "@store/desktop";
  import { onMount } from "svelte";

  let moving = false;
  let left = 200;
  let top = 150;

  export let appname: string = "Don't Know";

  export let debug = false;

  interface ITopData {
    title: string;
    color: string;
    background?: string | any;
    blurstrength?: number;
    blur?: boolean;
  }
  export let topdata: ITopData = {
    title: "Unknown",
    color: "#fff",
    blurstrength: 10,
    background: "rgba(50, 48, 60, 0.978);",
    blur: true,
  };

  function onMouseDown() {
    moving = true;
    if (!debug) {
      $openedApps.push(
        $openedApps.splice(
          $openedApps.findIndex((r) => r.name === appname),
          1
        )[0]
      );
      openedApps.set($openedApps);
    } else {
      console.log("DEBUG MODE: " + appname);
    }
  }

  function onMouseMove(e: { movementX: number; movementY: number }) {
    if (moving) {
      if (top + e.movementY < window.innerHeight * 0.05) {
        return
      }
      if (top + e.movementY > window.innerHeight - (window.innerHeight * 0.12)) {
        return
      }
      if (left + e.movementX < 0) {
        return
      }
      if (left + e.movementX > window.innerWidth - (window.innerWidth * 0.12)) {
        return
      }

      left += e.movementX;
      top += e.movementY;
    }
  }

  function onMouseUp() {
    moving = false;
  }
</script>

<div class="apps" style="--left: {left}px; --top: {top}px">
  <!-- 

    "background: {topdata.background ||
      'rgba(50, 48, 60, 0.978)'}; {topdata.blur
      ? `backdrop-filter: blur(${topdata.blurstrength || 5}px);`
      : ''};"
   -->
  <div
    class="app-container"
    in:fade|local={{ duration: 150, easing: cubicInOut }}
    out:fade|local={{ duration: 100 }}
    style={typeof topdata.background === "string"
      ? `background-color: ${
          topdata.background || "rgba(50, 48, 60, 0.978)"
        }; ${
          topdata.blur
            ? `backdrop-filter: blur(${topdata.blurstrength || 5}px);`
            : ""
        }`
      : topdata.background.css}
  >
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
    border-radius: 5px;
    position: absolute;
    left: var(--left);
    top: var(--top);
    transform: translate(-50px, -50px);
    width: 80%;
    height: 80%;
    overflow-y: hidden;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  }

  .ondrag {
    cursor: move;
  }
  .app-container {
    transition: background 0.3s ease;
    background-color: black;
    width: 100%;
    height: 100%;
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }

  .top {
    position: sticky;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 5px 0 15px;
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
