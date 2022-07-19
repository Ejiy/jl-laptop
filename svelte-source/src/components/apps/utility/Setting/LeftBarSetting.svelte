<script lang="ts">
  export let page = "Personalise";
</script>

<div class="left-bar">
  <div class="list">
    <div
      class="item"
      class:active={page === "Personalise"}
      on:click={() => {
        page = "Personalise";
      }}
    >
      <div class="icon">
        <ion-icon name="brush" />
      </div>
      <div class="text">
        <span>Personalise</span>
      </div>
    </div>
    <div
      class="item"
      class:active={page === "About"}
      on:click={() => {
        page = "About";
      }}
    >
      <div class="icon">
        <ion-icon name="alert-circle" />
      </div>
      <div class="text">
        <span>About</span>
      </div>
    </div>
  </div>
</div>

<style>
  .icon {
    margin-right: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  ion-icon {
    width: 20px;
    height: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .text {
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .left-bar {
    padding: 3px 10px;
    width: 25vh;
  }
  .list {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
  }
  .item {
    display: flex;
    font-weight: 500;
    align-items: center;
    justify-content: flex-start;
    width: 100%;
    height: 30px;
    padding: 3px 10px;
    margin: 3px 0;
    border-radius: 3px;
    color: #fff;
    font-size: 15px;
  }

  .item:hover,
  .item.active {
    background: rgba(247, 247, 247, 0.144);
  }
</style>
