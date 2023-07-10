<script lang="ts">
  import { fade, fly } from "svelte/transition";
  import { cubicInOut, cubicOut } from "svelte/easing";
  import { modals } from "@store/modals";

  function _onOk() {
    $modals.onOk($modals?.inputValue);
    modals.reset();
  }
  function _onCancel() {
    $modals.onCancel($modals?.inputValue);
    modals.reset();
  }

  function _onClose() {
    modals.reset();
  }
</script>

{#if $modals}
  <div class="modal-wrapper" transition:fade|local={{ duration: 500 }}>
    <div
      class="modal"
      in:fly|local={{ duration: 600, easing: cubicOut, y: 300 }}
      out:fly|local={{ duration: 400, easing: cubicInOut }}
    >
      <div class="top">
        <div class="title" style="float: left;">
          {$modals.title}
        </div>
        <div class="close" style="float: right;" on:click={_onClose}>
          <i
            class="fa-solid fa-circle-xmark"
            style="color: rgb(245, 105, 105); font-size: 15px;"
          />
        </div>
      </div>

      <div class="modal-c">
        <div class="description">
          {$modals.description}
        </div>
        <div class="input">
          {#if $modals.input}
            {#if $modals.inputType === "text"}
              <input
                type="text"
                bind:value={$modals.inputValue}
                placeholder={$modals.inputPlaceholder}
              />
            {:else if $modals.inputType === "number"}
              <input
                type="number"
                bind:value={$modals.inputValue}
                placeholder={$modals.inputPlaceholder}
              />
            {/if}
          {/if}
        </div>
        <div class="button">
          <button class="ok" on:click={_onOk}>
            {$modals.okText}
          </button>
          <button class="cancel" on:click={_onCancel}>
            {$modals.cancelText}
          </button>
        </div>
      </div>
    </div>
  </div>
{/if}

<style>
  button.ok {
    background: rgb(17, 122, 52);
  }
  button.cancel {
    background-color: rgb(245, 105, 105);
  }
  button {
    padding: 10px;
    border-radius: 3px;
    border: none;
    width: 80px;
    height: 25px;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
  }
  .button {
    gap: 5px;
    display: flex;
    justify-content: flex-end;
    margin-top: 10px;
  }
  .description {
    text-align: left;
    margin-top: 10px;
    margin-bottom: 10px;
    padding: 5px;
    height: 100%;
  }
  .input {
    margin-top: 10px;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  input:focus {
    outline: none;
  }
  input {
    width: 100%;
    height: 40px;
    border: 1px solid #ccc;
    border-radius: 5px;
    padding: 0 10px;
    font-size: 14px;
    color: #333;
    background: #fff;
  }
  .top {
    padding: 3px 5px;
    display: flex;
    justify-content: space-between;
  }
  .title {
    font-size: 15px;
    font-weight: bold;
    font-family: "Segoe UI", sans-serif;
  }
  .modal-c {
    font-family: "Segoe UI", sans-serif;
    font-size: 0.95rem;
    padding: 10px;
  }
  .modal-wrapper {
    z-index: 100;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
  }
  .modal {
    position: absolute;
    padding: 5px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    min-width: 300px;
    max-width: 500px;
    min-height: 150px;
    background-color: rgba(50, 56, 77, 0.527);
    backdrop-filter: blur(10px);
    border-radius: 6px;
  }
</style>
