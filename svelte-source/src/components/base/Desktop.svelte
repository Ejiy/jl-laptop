<script lang="ts">
  import { fly } from "svelte/transition";
  import Icons from "./Icons.svelte";
  import Notification from "./Notification.svelte";
  import ShittyRightSide from "./RightSide.svelte";
  import Winmanager from "./Winmanager.svelte";
  import { apps, openApp, openedApps, setApp } from "../../store/desktop";
  import { setSettings, settings } from "../../store/settings";
  import { cubicIn, cubicOut, quadOut } from "svelte/easing";
  import { fetchNui } from "../../utils/eventHandler";
  import Modal from "@shared/Modal.svelte";
  import { InitDumyAppData } from "@utils/initDumyData";
  import { flip } from "svelte/animate";
  // APP
  import Boosting from "@apps/Boosting.svelte";
  import Setting from "@apps/Setting.svelte";
  import BennyShop from "@apps/BennyShop.svelte";
  import Management from "@apps/Management.svelte";
  import DarkWeb from "@apps/DarkWeb.svelte";
  import Employment from "@components/apps/Employment.svelte";

  // Register your app component here
  let registeredApp: any = {
    boosting: Boosting,
    setting: Setting,
    bennys: BennyShop,
    boss: Management,
    darkweb: DarkWeb,
    employment: Employment,
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
          color: filtered[0].color,
        };
        if ($openedApps.filter((app) => app.name === data.name).length === 0) {
          openApp(data);
        }
      }
    }
  };

  let showRightside = false;
  let toggleRightside = () => {
    showRightside = !showRightside;
  };

  let toggleSetting = (st) => {
    if (st.detail === true) {
      handleOpenApp("setting");
    }
  };
  fetchNui("getapp", {})
    .then((res) => {
      setApp(res);
    })
    .catch(() => {
      InitDumyAppData();
    });

  fetchNui("setting/get", {}).then((res) => {
    if (res.status) {
      setSettings(res.data);
    }
  });

  function IClick(e) {
    const appname = e.detail;
    $openedApps.push(
      $openedApps.splice(
        $openedApps.findIndex((r) => r.name === appname),
        1
      )[0]
    );
    openedApps.set($openedApps);
  }
</script>

<div
  class="desktop"
  style="background-image: url({$settings.background});"
  in:fly={{ y: 1000, duration: 1000, easing: cubicOut }}
  out:fly={{ y: 1000, duration: 500, easing: cubicIn }}
>
  <Modal />
  <Icons on:openApp={handleOpenApp} />
  <div class="app-wrapper">
    {#each $openedApps as app (app.name)}
      <svelte:component this={app.component} />
    {/each}
  </div>
  <Notification />
  <ShittyRightSide {showRightside} />
  <Winmanager
    on:IClick={IClick}
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
