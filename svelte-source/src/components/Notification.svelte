<script>
  import { flip } from "svelte/animate";
  import { fly } from "svelte/transition";
  import { notifications } from "../store/notifications";
  import { cubicIn, cubicInOut, cubicOut } from "svelte/easing";
</script>

<div class="notifications">
  {#each $notifications as notification (notification.id)}
    <div
      class="notif"
      animate:flip={{ duration: 150, easing: cubicInOut }}
      in:fly={{ x: 300, easing: cubicOut }}
      out:fly={{ x: 500, easing: cubicIn }}
    >
      <div
        class="icon"
        style="background-color: {notification.app.background};"
      >
        {#if notification.app.useimage}
          <img
            src={`./images/apps/${notification.app.name}.png`}
            alt={notification.app.name}
          />
        {:else}
          <i class={notification.app.icon} />
        {/if}
      </div>
      <div class="content">
        <div class="description">
          {notification.message}
        </div>
      </div>
    </div>
  {/each}
</div>

<style>
  .notifications {
    z-index: 100;
    display: flex;
    flex-direction: column;
    flex-wrap: wrap;
    position: fixed;
    bottom: 5%;
    right: 0;
    font-family: "Noto", sans-serif;
    font-size: 15px;
    font-weight: bold;
  }
  .notif {
    display: flex;
    align-items: center;
    padding: 5px;
    margin: 3px 6px;
    min-width: 400px;
    min-height: 80px;
    background: rgba(75, 77, 91, 0.508);
    backdrop-filter: blur(10px);
    overflow-x: hidden;
    border-radius: 3px;
  }

  .icon {
    margin: 0px 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 20px;
    width: 50px;
    height: 50px;
    border-radius: 3px;
  }

  .icon img {
    width: 100%;
    height: 100%;
    padding: 10px;
  }
</style>
