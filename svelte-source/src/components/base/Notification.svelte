<script lang="ts">
  import { flip } from "svelte/animate";
  import { fly } from "svelte/transition";
  import { notifications } from "@store/notifications";
  import {
    cubicIn,
    cubicInOut,
    cubicOut,
    quadInOut,
    quadOut,
  } from "svelte/easing";

  let notif: any = $notifications;

  function removeNotif(id) {
    notifications.set(notif.filter((i) => i.id !== id));
  }
  // I will find the better solution later 😂
  $: {
    notif = $notifications;
  }
</script>

<div class="notifications">
  {#each notif as notification (notification.id)}
    <div
      on:click={() => removeNotif(notification.id)}
      class="notification-item"
      animate:flip={{ duration: 400, easing: quadInOut }}
      in:fly={{ x: 300, easing: cubicOut }}
      out:fly={{ x: 500, easing: cubicIn }}
    >
      <div
        class="images"
        style="background-color: {notification?.app?.background ??
          notification.addon.background};"
      >
        {#if notification.app}
          {#if notification.app.useimage}
            <img
              src={`./images/apps/${notification.app.name}.png`}
              alt={notification.app.name}
            />
          {:else if notification.app.icon.startsWith("fa-") | notification.app.icon.startsWith("fas")}
            <i
              class={notification.app.icon}
              style="color: {notification.app.icon.color}"
            />
          {:else}
            <ion-icon
              name={notification.app.icon}
              style="color: {notification.app.color}; font-size: 25px"
            />
          {/if}
        {:else if notification.addon}
          {#if notification.addon.icon.startsWith("fa-") | notification.addon.icon.startsWith("fas")}
            <i
              class={notification.addon.icon}
              style="color: {notification.addon.color};"
            />
          {:else}
            <ion-icon
              name={notification.addon.icon}
              style="color: {notification.addon.color}; font-size: 25px"
            />
          {/if}
        {/if}
      </div>
      <div class="messages">{notification.message}</div>
    </div>
  {/each}
</div>

<style>
  .messages {
    max-width: 80%;
    margin-right: 5px;
    padding: 5px;
  }
  .notifications {
    z-index: 1000;
    position: fixed;
    bottom: 5%;
    right: 20px;
    margin: 0 auto;
    padding: 0;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    align-items: flex-end;

    font-family: "Noto", sans-serif;
    font-size: 15px;
    font-weight: bold;
  }

  .images img {
    width: 100%;
    height: 100%;
    padding: 10px;
  }
  .images {
    margin: 0px 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 20px;
    width: 50px;
    height: 50px;
    border-radius: 3px;
  }
  .notification-item {
    overflow: hidden;
    gap: 5px;
    min-width: 200px;
    max-width: 400px;
    height: 80px;
    display: flex;
    justify-content: flex-start;
    align-items: center;
    color: white;
    background: rgba(75, 77, 91, 0.508);
    backdrop-filter: blur(10px);
    border-radius: 4px;
    margin-bottom: 10px;
    box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.1);
  }
</style>
