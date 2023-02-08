<script lang="ts">
  import { apps } from "@store/desktop";
  import { settings } from "@store/settings";
  import { flip } from "svelte/animate";
  import { fade } from "svelte/transition";
  import { createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher();
  let openApp = (app: string) => {
    dispatch("openApp", app);
  };
</script>

<div class="icons">
  {#each $apps as icon (icon.name)}
    <div
      class="icon"
      class:hide={icon.hide}
      animate:flip={{ duration: 500 }}
      transition:fade|local
    >
      <div
        class="icon-back"
        style="background-color: {icon.background}"
        on:click={(e) => {
          openApp(icon.name);
        }}
      >
        {#if icon.useimage}
          <img
            src={"./images/apps/" + icon.name + ".png"}
            alt={icon.name}
            class="image"
          />
        {:else if icon.icon.startsWith("fa-") || icon.icon.startsWith("fas")}
          <i class={icon.icon} style="color: {icon.color};" />
        {:else}
          <ion-icon
            name={icon.icon}
            style="color: {icon.color}; font-size: 25px"
          />
        {/if}
      </div>
      <p class="text" class:dark={$settings.darkfont}>{icon.text}</p>
    </div>
  {/each}
</div>

<style>
  .icon.hide {
    display: none;
  }
  .text.dark {
    color: rgb(31, 31, 31);
  }

  /* .boosting .image {
    width: 100%;
    height: 100%;
    padding: 0;
  } */
  .image {
    padding: 5px;
    width: 80%;
    height: 80%;
  }
  .text {
    /* color: rgb(255, 255, 255); */
    transition: all 0.5s ease;
    font-size: 12px;
    font-family: "Segoe UI", sans-serif;
    font-weight: 700;
  }

  .icons {
    display: flex;
    flex-wrap: wrap;
    justify-content: start;
    align-items: center;
    flex-direction: column;
    height: 100%;
    width: fit-content;
    margin: 10px;
  }

  .sheesh {
    color: rgb(13, 32, 69);
  }

  i {
    font-size: 20px;
  }

  .icon {
    /* make it center */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  /* .boosting .icon-back {
    padding: 0;
  } */

  .icon-back {
    width: 50px;
    height: 50px;
    /* background-color: rgb(0, 0, 0); */
    border-radius: 6px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 10px;
    cursor: pointer;
  }

  /* make media for 720p */
  @media screen and (max-width: 1280px) {
    .icon-back {
      width: 40px;
      height: 40px;
    }

    i {
      font-size: 15px;
    }
    .text {
      font-size: 10px;
    }
  }

  @media screen and (min-width: 1440px) {
  }
</style>
