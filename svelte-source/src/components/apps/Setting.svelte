<script lang="ts">
  import { settings } from "@store/settings";
  import Apps from "@shared/Apps.svelte";
  import LeftBarSetting from "./utility/Setting/LeftBarSetting.svelte";
  import Toggle from "@shared/Toggle.svelte";
  import { fly, fade } from "svelte/transition";
  import { cubicOut, quadInOut } from "svelte/easing";

  import wp1 from "@assets/wallpaper/wp1.png";
  import wp2 from "@assets/wallpaper/wp2.jpg";
  import wp3 from "@assets/wallpaper/wp3.jpg";
  import wp4 from "@assets/wallpaper/wp4.png";
  import { modals } from "@store/modals";
  import { notifications } from "@store/notifications";
  import { onDestroy } from "svelte";
  import { fetchNui } from "@utils/eventHandler";

  let currentPage = "Personalise";
  let wallpaperlist = [wp1, wp2, wp3, wp4];

  function handleWallpaperClick(src: string) {
    settings.update((s) => {
      return { ...s, background: src };
    });
  }

  function customWallpaper() {
    modals.show({
      show: true,
      onOk: (value) => {
        const reg = /(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)/g;
        if (reg.test(value)) {
          settings.update((s) => {
            return { ...s, background: value };
          });
          notifications.send("Wallpaper Changed", "setting");
        } else {
          notifications.send("Invalid URL", "setting");
        }
      },
      onCancel: () => {},
      title: "Custom Wallpaper",
      input: true,
      inputPlaceholder: "URL",
      okText: "Confirm",
      cancelText: "Cancel",
      description: "",
      inputType: "text",
      inputValue: "",
    });
  }

  onDestroy(() => {
    fetchNui("setting/save", {
      setting: $settings,
    });
  });
</script>

<Apps
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
              <div class="custom" on:click={customWallpaper}>
                <ion-icon class="sh" name="add-circle" size="large" />
              </div>
              {#each wallpaperlist as wp}
                <div
                  class="images"
                  class:active={wp === $settings.background}
                  style="background-image: url('{wp}');"
                  on:click={() => {
                    handleWallpaperClick(wp);
                  }}
                />
              {/each}
            </div>
          </div>
          <div class="font-setting">
            <h2>Font</h2>

            <div class="font-dark">
              <span>Dark Font ( desktop icon )</span>
              <Toggle bind:checked={$settings.darkfont} />
            </div>
          </div>
        </div>
      {:else if currentPage === "About"}
        <div
          class="main-page about"
          in:fly|local={{ y: 400, easing: cubicOut, duration: 500 }}
          out:fade|local={{ easing: quadInOut, duration: 100 }}
        >
          <div class="title">Thanks</div>
          <div class="desc">
            I'm JL as the lead developer of this project. I want to say Thanks
            to all of the people who have helped me to make this project
            possible. We have worked on this project for more than a month, we
            glad we could make this project release to the public especially for
            qbcore community.
          </div>
          <div class="title">Main Developer</div>
          <div class="jl-rn">
            <div class="justlazzy">
              <div class="org-logo">
                <img
                  src="https://cdn.discordapp.com/attachments/995214046414508094/995214463223464036/Comission_Alit_20220204211842.png"
                  alt="justlazzy"
                />
              </div>
              <div class="org-title">JL Development</div>
              <div class="names">
                <div class="name">• JustLazzy</div>
                <div class="name">• Darkets</div>
              </div>
            </div>
            <div class="renewed">
              <div class="org-logo">
                <img
                  src="https://media.discordapp.net/attachments/981153056643231744/998868151011921920/9a7d15408011ae470b767fa41a8abaced7370574.png"
                  alt="renewed"
                />
              </div>
              <div class="org-title">Renewed Scripts</div>
              <div class="names">
                <div class="name">• FjamZoo</div>
                <div class="name">• uShifty</div>
              </div>
            </div>
          </div>
          <div class="title">Other Contributors</div>

          <div class="other-contributor">
            <div class="contributor">
              <div class="contributor-logo">
                <img
                  src="https://media.discordapp.net/attachments/921376697792733184/998877019402162206/91106435.jpg"
                  alt="silent"
                />
              </div>
              <div class="name">S1lentcodes / Silent</div>
            </div>
            <div class="contributor">
              <div class="contributor-logo">
                <img
                  src="https://media.discordapp.net/attachments/981153056643231744/998872979100414002/79489495.png"
                  alt="jayden"
                />
              </div>
              <div class="contributor-name">Alivemonstor / Jayden</div>
            </div>
            <div class="contributor">
              <div class="contributor-logo">
                <img
                  src="https://media.discordapp.net/attachments/921376697792733184/998878693764124742/50504920.gif"
                  alt="hyper"
                />
              </div>
              <div class="name">Hyper / itsHyper</div>
            </div>
          </div>
        </div>
      {/if}
    </div>
  </div>
</Apps>

<style>
  .images {
    border-radius: 2px;
    transition: transform 0.5s ease, box-shadow 0.5s ease;
    width: 500px;
    height: 270px;
    background-position: center;
    background-size: cover;
  }
  .contributor {
    display: flex;
    align-items: center;
    flex-direction: column;
    justify-content: center;
  }
  .contributor-logo {
    width: 100px;
    height: 100px;
    overflow: hidden;
    border-radius: 50%;
  }

  .other-contributor {
    display: flex;
    flex-direction: row;
    justify-content: center;
    gap: 50px;
    align-items: center;
    margin: 50px;
    margin-bottom: 50px;
  }
  .main-page.about::-webkit-scrollbar {
    display: none;
  }
  .main-page.about {
    scrollbar-width: none;
  }
  .main-page {
    height: 100%;
    overflow-x: hidden;
    overflow-y: auto;
  }
  .name {
    font-size: 18px;
    color: #fff;
  }
  .desc {
    padding: 20px;
    text-align: justify;
  }
  .org-title {
    margin-bottom: 10px;
    font-size: 20px;
    font-weight: bold;
    color: #fff;
  }
  .renewed,
  .justlazzy {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }
  img {
    width: 100%;
    height: 100%;
  }
  .org-logo {
    width: 150px;
    height: 150px;
    margin: 0 auto;
  }
  .jl-rn {
    margin-top: 50px;
    gap: 100px;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
  }
  .title {
    margin-top: 30px;
    text-align: center;
    font-size: 1.5rem;
    font-weight: bold;
    color: #fff;
    margin-bottom: 10px;
  }
  .sh:hover {
    animation: spinner 4s linear infinite;
  }

  .custom:hover {
    background-color: rgba(0, 0, 0, 0.226);
  }
  .custom {
    transition: background-color 0.5s ease;
    border-radius: 2px;
    width: 500px;
    height: 270px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
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
  .images.active {
    border: 2px solid #fff;
    transform: scale(1.01);
  }
  .font-setting {
    margin-top: 20px;
  }
  .images:hover {
    cursor: pointer;
    transform: scale(1.01);
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  }

  .list {
    padding: 10px 0;
    box-sizing: border-box;
    margin-top: 10px;
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
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
