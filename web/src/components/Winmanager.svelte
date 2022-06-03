<script>
  import { createEventDispatcher } from "svelte";
  let showRightside = false;
  let dispatcher = createEventDispatcher();
  let toggleRightside = () => {
    showRightside = !showRightside;
    dispatcher("toggleRightside", showRightside);
  };
  let showsetting = false;
  let showingSetting = () => {
    showsetting = !showsetting;
  };
</script>

<div class="winmanager">
  <div class="left-icons">
    <div class="start-icon">
      <div class="icon-start">
        <img class="start" src="./images/logo.png" alt="icon" />
      </div>
    </div>
  </div>
  <div class="right-icons">
    <i
      id="setting"
      class="fas fa-duotone fa-gear"
      class:fa-spin={showsetting}
      on:click={showingSetting}
    />
    <i class="fas fa-solid fa-wifi" />
    <div class="times">
      <span id="time">4:05 PM</span>
      <span id="date">5/3/2022</span>
    </div>

    <i
      class="fa-regular fa-message"
      style="cursor: pointer;"
      on:click={toggleRightside}
    />
  </div>
</div>

<style>
  #setting {
    cursor: pointer;
  }
  .times {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    font-size: 12px;
    font-family: "Segoe UI", sans-serif;
    margin: 0 15px;
  }
  .right-icons {
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    padding: 15px;
    right: 0;
  }

  .right-icons i {
    font-size: 15px;
    margin: 0 10px;
  }
  .icon-start {
    border-radius: 3px;
  }

  .start {
    height: 40px;
  }
  .winmanager {
    padding: 0 10px;
    width: 100%;
    height: 40px;
    position: absolute;
    bottom: 0;
    background: rgba(75, 77, 91, 0.353);
    backdrop-filter: blur(10px);
    display: flex;
    bottom: 0;
    overflow-y: hidden;
    align-items: center;
    z-index: 98;
  }
</style>
