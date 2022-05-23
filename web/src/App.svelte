<script>
  import axios from "axios";
  import { onDestroy, onMount } from "svelte";
  import Desktop from "./components/Desktop.svelte";
  import { contracts } from "./store/boosting";
  import { notifications } from "./store/notifications";
  let active = false;
  let toggleActive = (boolean) => {
    active = boolean === undefined ? !active : boolean;
  };
  let showRightside = false;
  let closeLaptop = () => {
    toggleActive(false);
    fetch("https://ps-laptop/close", {
      method: "POST",
      body: JSON.stringify({}),
      headers: {
        "Content-type": "application/json",
      },
    }).catch();
  };

  onMount(() => {
    console.log("mounted");
  });

  let toggleRightside = (e) => {
    showRightside = e.detail;
  };

  let HandleNewContracts = (table) => {
    contracts.set([table[0], ...$contracts]);
    console.log($contracts);
  };

  window.addEventListener("message", function (event) {
    switch (event.data.type) {
      case "toggle":
        toggleActive(event.data.status);
        break;
      case "receivecontracts":
        HandleNewContracts(event.data.contracts);
        break;
    }
  });

  onDestroy(() => {
    window.removeEventListener("message");
    console.log("destroyed");
  });

  document.onkeydown = function (data) {
    if (data.repeat) return;
    switch (data.key) {
      case "Escape":
        closeLaptop();
        break;
      case "Backspace":
        closeLaptop();
        break;
    }
  };
</script>

<main>
  <div id="app">
    {#if active}
      <Desktop />
    {/if}
  </div>
</main>

<style>
</style>
