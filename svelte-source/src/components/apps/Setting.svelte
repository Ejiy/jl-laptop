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
    "https://mishaburnett.files.wordpress.com/2022/04/max.png",
    "https://techyhost.com/wp-content/uploads/2019/10/Rainmeter-Skin-1.jpg",
    "https://www.whatspaper.com/wp-content/uploads/2022/03/cyberpunk-wallpaper-whatspaper-9.jpg",
    "https://wallpapercave.com/wp/wp6065533.png",
    "https://wallpaperaccess.com/full/5212923.jpg",
    "https://i.pinimg.com/originals/67/7d/d0/677dd0ea60b8c98e8ff496449ab65bfe.jpg",
    "https://wallpaperaccess.com/full/3047149.jpg",
    "https://img3.wallspic.com/crops/1/9/5/6/6/166591/166591-bmw-cars-sports_car-compact_car-a_segment-1920x1080.jpg",
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
