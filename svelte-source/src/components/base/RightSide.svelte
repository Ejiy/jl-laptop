<script lang="ts">
  import { fade, fly } from "svelte/transition";
  import { cubicOut, cubicInOut } from "svelte/easing";
  import { flip } from "svelte/animate";
  import oldNotifications from "@store/oldnotification";
  import { notifications } from "@store/notifications";
  export let showRightside = false;
</script>

{#if showRightside}
  <div
    class="right-side"
    in:fly|local={{ x: 500, easing: cubicOut }}
    out:fly|local={{ x: 500, duration: 300, easing: cubicInOut }}
  >
    <div class="controls">
      <div class="title">Notifications</div>
      {#if $oldNotifications.length > 0}
        <button
          class="clear"
          on:click={() => {
            oldNotifications.clear();
          }}
        >
          Clear all
        </button>
      {/if}
    </div>
    <div class="notifications">
      {#each $oldNotifications as notification, index (notification.id)}
        <div
          class="notif"
          out:fly|local={{ x: 300 }}
          animate:flip={{ easing: cubicOut, duration: 300 }}
          in:fade|local
        >
          <div
            class="icon"
            style="background-color: {notification?.app?.background ??
              notification.addon.background};"
          >
            {#if notification.app}
              {#if notification.app.useimage}
                <img
                  src={`./images/apps/${notification.app.name}.png`}
                  alt={notification.app.name}
                />
              {:else if notification.app.icon.startsWith("fa-") || notification.app.icon.startsWith("fas")}
                <i
                  class={notification.app.icon}
                  style="color: {notification.app.color ?? 'white'};"
                />
              {:else}
                <ion-icon
                  name={notification.app.icon}
                  style="color: {notification.app.color}; font-size: 25px"
                />
              {/if}
            {:else if notification.addon}
              {#if notification.addon.icon.startsWith("fa-") || notification.addon.icon.startsWith("fas")}
                <i
                  class={notification.addon.icon}
                  style="color: {notification.addon.color ?? 'white'};"
                />
              {:else}
                <ion-icon
                  name={notification.addon.icon}
                  style="color: {notification.addon.color ??
                    'white'}; font-size: 25px"
                />
              {/if}
            {/if}
          </div>
          <div class="information">
            <div class="description">
              {notification.message.length > 15
                ? notification.message.substring(0, 15) + "..."
                : notification.message}
            </div>
          </div>
          <div class="top">
            <!-- x icon -->
            <i
              class="fa-solid fa-xmark"
              on:click={() => {
                oldNotifications.remove(notification.id);
              }}
            />
          </div>
        </div>
      {:else}
        <div class="error-notif" transition:fade>
          <div class="error-text">No notifications</div>
        </div>
      {/each}
    </div>
  </div>
{/if}

<style>
  .top {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    flex: 3;
  }
  .icon {
    margin: 0px 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 45px;
    height: 45px;
    border-radius: 3px;
    background-color: #494570;
  }

  .icon img {
    width: 100%;
    height: 100%;
    padding: 10px;
  }

  .text {
    font-size: 1.2rem;
    font-family: "Noto Sans", sans-serif;
  }
  .error-notif {
    font-family: "Segoe UI", sans-serif;
    position: absolute;
    top: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
  }
  .notif {
    display: flex;
    flex-direction: row;
    align-items: center;
    background: transparent;
    margin-top: 3px;
    padding: 10px;
    min-height: 80px;
    width: 99%;
    backdrop-filter: blur(10px);
  }

  button.clear {
    background: #494570;
    color: #fff;
    border: none;
    padding: 5px;
    font-size: 12px;
    font-family: "Segoe UI", sans-serif;
    background: rgba(75, 77, 91, 0.508);
    border-radius: 3px;
    min-width: 60px;
    cursor: pointer;
  }
  .right-side {
    margin-right: 10px;
    position: absolute;
    top: 50%;
    right: 0;
    transform: translate(0, -50%);
    border-radius: 5px;
    min-width: 300px;
    max-width: 600px;
    height: 90%;
    background: rgba(75, 77, 91, 0.508);
    backdrop-filter: blur(10px);
    overflow-x: hidden;
  }
  .notifications {
    display: flex;
    flex-direction: column-reverse;
    align-items: center;
    justify-content: center;
    overflow-y: auto;
  }
  /* make media for 720p screen */
  @media screen and (max-width: 1280px) {
    .right-side {
      height: 80%;
      min-width: 280px;
    }
  }
  .description {
    font-size: 0.9rem;
    font-family: "Noto Sans", sans-serif;
    cursor: pointer;
  }
  .title {
    font-family: "Noto", sans-serif;
    font-size: 15px;
    font-weight: bold;
  }
  .controls {
    position: sticky;
    padding: 10px;
    top: 0;
    display: flex;
    justify-content: space-between;
    overflow-y: hidden;
    align-items: center;
    background: rgb(40, 41, 49);
    height: 40px;
    z-index: 10;
  }
  ::-webkit-scrollbar {
    display: none;
  }
</style>
