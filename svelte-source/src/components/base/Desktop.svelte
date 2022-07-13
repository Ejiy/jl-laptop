<script lang="ts">
  import { fly } from "svelte/transition";
  import Icons from "./Icons.svelte";
  import Notification from "./Notification.svelte";
  import ShittyRightSide from "./RightSide.svelte";
  import Winmanager from "./Winmanager.svelte";
  import { apps, openApp, openedApps, setApp } from "../../store/desktop";
  import { settings } from "../../store/settings";
  import { cubicIn, cubicOut } from "svelte/easing";

  // APP
  import Boosting from "../apps/Boosting.svelte";
  import Browser from "../apps/Browser.svelte";
  import { fetchNui } from "../../utils/eventHandler";
  import { globals } from "svelte/internal";
  import Setting from "../apps/Setting.svelte";
  import Shop from "../apps/Shop.svelte";

  // Register your app component here
  let registeredApp: any = {
    browser: Browser,
    boosting: Boosting,
    setting: Setting,
    shop: Shop,
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
          icon: filtered[0].icon,
          background: filtered[0].background,
          useimage: filtered[0].useimage,
        };
        openApp(data);
      }
    }
  };

  fetchNui("getapp", {})
    .then((res) => {
      setApp(res);
    })
    .catch(() => {
      let data = [
        {
          name: "boosting",
          icon: "fa-solid fa-bolt",
          text: "Boosting",
          color: "#fff",
          background: "#1d2029",
          isopen: false,
          useimage: true,
        },
        {
          name: "shop",
          icon: "fa-solid fa-shopping-cart",
          text: "Shop",
          color: "#fff",
          background: "#352968",
          isopen: false,
          useimage: false,
        },
        {
          name: "browser",
          icon: "fa-solid fa-globe",
          text: "Browser",
          color: "#fff",
          background: "#aa2e25",
          isopen: false,
          useimage: false,
        },
        {
          name: "boss",
          icon: "fa-solid fa-circle-user",
          text: "Management",
          color: "#fff",
          background: "#4B5D67",
          isopen: false,
          useimage: false,
        },
        {
          name: "setting",
          icon: "fa-solid fa-cog",
          text: "Setting",
          color: "#fff",
          background: "#4B5D67",
          isopen: false,
          useimage: false,
        },
      ];
      setApp(data);
    });

  let showRightside = false;
  let toggleRightside = () => {
    showRightside = !showRightside;
  };

  let toggleSetting = (st) => {
    if (st.detail === true) {
      handleOpenApp("setting");
    }
  };
</script>

<div
  class="desktop"
  style="background-image: url({$settings.background});"
  in:fly={{ y: 1000, duration: 1000, easing: cubicOut }}
  out:fly={{ y: 1000, duration: 500, easing: cubicIn }}
>
  <Icons on:openApp={handleOpenApp} />
  <!-- <Shop /> -->
  {#each $openedApps as app, index (app.name)}
    <svelte:component this={app.component} />
  {/each}
  <Notification />
  <ShittyRightSide {showRightside} />
  <Winmanager
    on:toggleRightside={toggleRightside}
    on:showingSetting={toggleSetting}
  />
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
