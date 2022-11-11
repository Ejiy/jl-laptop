<script lang="ts">
  import { createEventDispatcher, onDestroy, onMount } from "svelte";
  import logo from "@assets/logo.png";
  import { openedApps } from "@store/desktop";
  import { flip } from "svelte/animate";
  import { fade, scale } from "svelte/transition";
  import { cubicIn, cubicInOut, cubicOut } from "svelte/easing";

  interface ITime {
    times: string;
    date: string;
  }
  let time: ITime = {
    times: "--:-- AM",
    date: "-/-/----",
  };
  let showRightside = false;
  let dispatch = createEventDispatcher();
  let toggleRightside = () => {
    showRightside = !showRightside;
    dispatch("toggleRightside", showRightside);
  };

  let showsetting = false;
  let showingSetting = () => {
    showsetting = !showsetting;
    dispatch("showingSetting", showsetting);
  };

  function SetTime(data: any) {
    if (data.minute <= 9) {
      data.minute = "0" + data.minute;
    }

    const date = new Date();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const year = date.getFullYear();
    const dateString = month + "/" + day + "/" + year;
    let stringData = data.hour + ":" + data.minute;
    time = {
      times: stringData,
      date: dateString,
    };
  }

  function Event(event: any) {
    if (event.data.action === "time") {
      SetTime(event.data.time);
    }
  }

  function IClick(appname: string) {
    dispatch("IClick", appname);
  }

  onMount(() => {
    window.addEventListener("message", Event);
  });

  onDestroy(() => {
    window.removeEventListener("message", Event);
  });
</script>

<div class="winmanager">
  <div class="left-icons">
    <div class="start-icon">
      <div class="icon-start">
        <img class="start" src={logo} alt="icon" />
      </div>
      <div class="opened-apps" style="margin-left: 5px;">
        {#each $openedApps as openApp (openApp.name)}
          <div
            on:click={() => IClick(openApp.name)}
            animate:flip={{ easing: cubicOut, duration: 200 }}
            class="open-icon"
            style="background-color: {openApp.background};"
            in:fade={{ easing: cubicInOut }}
            out:scale={{ easing: cubicIn, duration: 250, opacity: 2 }}
          >
            {#if openApp.useimage}
              <img
                class="icon"
                style="width: 70%;"
                src={`./images/apps/${openApp.name}.png`}
                alt={openApp.name}
              />
            {:else if openApp.icon.startsWith("fa-") || openApp.icon.startsWith("fas")}
              <i
                class={openApp.icon}
                style="font-size: 18px; color: {openApp.color};"
              />
            {:else}
              <ion-icon
                name={openApp.icon}
                style="font-size: 25px; color: {openApp.color};"
              />
            {/if}
          </div>
        {/each}
      </div>
    </div>
  </div>
  <div class="right-icons">
    <i class="fa-solid fa-user-shield" />
    <i class="fas fa-solid fa-wifi" />
    <div class="times">
      <span id="time">{time.times ? time.times : "..."}</span>
      <span id="date">{time.date ? time.date : "..."}</span>
    </div>
    <i
      class="fa-regular fa-message"
      style="cursor: pointer;"
      on:click={toggleRightside}
    />
  </div>
</div>

<style>
  .open-icon {
    width: 35px;
    height: 35px;
    border-radius: 3px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .opened-apps {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0px;
    height: 100%;
    gap: 5px;
  }
  .times {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    font-size: 12px;
    font-family: "Segoe UI", sans-serif;
    margin: 0 15px;
  }
  .right-icons {
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    padding: 15px;
    right: 0;
  }

  .right-icons i {
    font-size: 15px;
    margin: 0 10px;
  }
  .icon-start {
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 3px;
    width: 100%;
    height: 100%;
    background-color: rgba(255, 255, 255, 0.123);
  }

  .start {
    height: 40px;
  }

  .winmanager {
    padding: 0 10px;
    width: 100%;
    height: 40px;
    position: absolute;
    bottom: 0;
    background: #1a1c25b9;
    backdrop-filter: blur(10px);
    display: flex;
    bottom: 0;
    overflow-y: hidden;
    align-items: center;
    z-index: 98;
  }

  .left-icons {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .left-icons img {
    display: flex;
    justify-content: center;
  }

  .start-icon {
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
