<script>
  import Apps from "@shared/Apps.svelte";
  import ManagementCard from "./utility/Management/ManagementCard.svelte";
  import ManagementLeftBar from "./utility/Management/ManagementLeftBar.svelte";
  let currentPage = "Manage Employee";

  let dummyData = [
    {
      name: "JustLazzy",
      cid: "CID-001",
      grades: "Cadet",
      profile: "https://cdn3.emoji.gg/emojis/3394-cursed-sad-cowboy.png",
      number: "6969",
    },
    {
      name: "Fjam",
      cid: "CID-002",
      grades: "Cadet",
      profile: "https://cdn3.emoji.gg/emojis/3394-cursed-sad-cowboy.png",
    },
    {
      name: "TheBullyDev",
      cid: "CID-003",
      grades: "Cadet",
      profile: "https://cdn3.emoji.gg/emojis/3394-cursed-sad-cowboy.png",
    },
  ];
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
    <div class="left">
      <ManagementLeftBar bind:page={currentPage} />
    </div>
    <div class="pages">
      {#if currentPage === "Manage Employee"}
        <div class="search-bar">
          <input type="text" placeholder="Search" />
        </div>
        <div class="main-page">
          {#each dummyData as data}
            <ManagementCard
              name={data.name}
              cid={data.cid}
              grades={data.grades}
              profile={data.profile}
            />
          {/each}
        </div>
      {/if}
    </div>
  </div>
</Apps>

<style>
  input:focus {
    outline: none;
  }
  .search-bar input {
    width: 100%;
    height: 40px;
    border: 1px solid #2c363967;
    border-radius: 5px;
    padding: 0 10px;
    font-size: 15px;
    font-weight: bold;
    color: white;
    background: none;
  }
  .search-bar {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px;
    font-size: 15px;
    font-weight: bold;
    gap: 5px;
    border-bottom: 2px solid #3c536067;
  }
  .pages {
    width: 100%;
    overflow-x: hidden;
    height: 100%;
  }
  .main-page {
    padding: 10px;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 30px;
    width: 100%;

    overflow-x: hidden;
  }
  .app-component {
    display: flex;
    height: 100%;
    overflow: hidden;
  }
  * {
    font-family: "Segoe UI", sans-serif;
  }
</style>
