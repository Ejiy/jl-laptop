<script lang="ts">
  import { dark, wallpaper } from "../../store/desktop";
  import Apps from "../../providers/Apps.svelte";
  import LeftBarSetting from "./utility/LeftBarSetting.svelte";
  import Toggle from "../../providers/Toggle.svelte";
  import { fly, fade } from "svelte/transition";
  import { cubicIn, cubicOut, quadInOut } from "svelte/easing";
  let currentPage = "Personalise";

  let darkdesktop = $dark;

  let wallpaperlist = [
    "https://images8.alphacoders.com/114/1143202.jpg",
    "https://i.pinimg.com/originals/8a/5b/6e/8a5b6e45d0d89a812ed8e28c8f0b3730.jpg",
    "https://wallpaper.dog/large/20511548.jpg",
    "https://wallpaper.dog/large/794259.jpg",
    "https://fashionsista.co/wallpaper/wallpaper/20210114/rimuru-tempest-4k-8k-hd-that-time-i-got-reincarnated-as-a-preview.webp",
  ];

  function handleWallpaperClick(src: string) {
    console.log(src);
    wallpaper.set(src);
  }

  function isActive(str: string) {
    console.log($wallpaper);
    if ($wallpaper === str) {
      return true;
    } else {
      return false;
    }
  }
  $: {
    dark.set(darkdesktop);
  }
</script>

<Apps
  debug={true}
  appname="setting"
  topdata={{
    title: "Setting",
    color: "#1a1c25",
    blur: true,
    blurstrength: 15,
    background: "#2f364ecb",
  }}
>
  <div class="body">
    <div class="left-bar">
      <LeftBarSetting bind:page={currentPage} />
    </div>

    <div class="pages">
      {#if currentPage === "Personalise"}
        <div
          class="main-page"
          in:fly|local={{ y: 400, easing: cubicOut, duration: 500 }}
          out:fade|local={{ easing: quadInOut, duration: 100 }}
        >
          <div class="wallpaper-setting">
            <h2>Wallpaper</h2>
            <div class="list">
              {#each wallpaperlist as wp}
                <img
                  class:active={$wallpaper === wp}
                  on:click={() => {
                    handleWallpaperClick(wp);
                  }}
                  src={wp}
                  class="wallpaper-item"
                  alt="wlpper"
                  style="width: 500px; margin: 10px;"
                />
              {/each}
            </div>
          </div>
          <div class="font-setting">
            <h2>Font</h2>

            <div class="font-dark">
              <span>Dark Font ( desktop icon )</span>
              <Toggle bind:checked={darkdesktop} />
            </div>
          </div>
        </div>
      {:else if currentPage === "System"}
        <div
          class="main-page"
          in:fly|local={{ y: 400, easing: cubicOut, duration: 500 }}
          out:fade|local={{ easing: quadInOut, duration: 100 }}
        >
          test
        </div>
      {/if}
    </div>
  </div>
</Apps>

<style>
  .font-dark {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 300px;
    height: 30px;
    margin: 3px 0;
    border-radius: 3px;
    color: #fff;
    font-size: 15px;
  }
  .wallpaper-item.active {
    border: 2px solid #fff;
    transform: scale(1.01);
  }
  .font-setting {
    margin-top: 20px;
  }
  .wallpaper-item:hover {
    cursor: pointer;
    transform: scale(1.01);
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  }

  .wallpaper-item {
    transition: all 0.1s ease-in-out;
  }
  .list {
    margin-top: 10px;
    display: flex;
    flex-wrap: wrap;

    justify-content: center;
    width: 100%;
    height: 300px;
    overflow-y: auto;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  }
  .body {
    display: flex;
    height: 100%;
  }
  .left-bar {
    width: 25vh;
  }
  .pages {
    width: 100%;
    height: 100%;
    padding: 10px;
  }

  * {
    font-family: "Segoe UI", sans-serif;
  }
</style>
