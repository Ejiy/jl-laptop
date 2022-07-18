<script>
  import Apps from "../shared/Apps.svelte";
  import ManagementLeftBar from "./utility/Management/ManagementLeftBar.svelte";
</script>

<Apps
  appname="boss"
  topdata={{
    color: "#1B2430",
    title: "Management",
    background: "#2c363967",
    blur: true,
    blurstrength: 30,
  }}
  debug={true}
>
  <div class="app-component">
    <ManagementLeftBar />
  </div>
</Apps>

<style>
  .app-component {
    overflow: hidden;
  }
  * {
    font-family: "Segoe UI", sans-serif;
  }
</style>
