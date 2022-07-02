<script>
  import Apps from "../../providers/Apps.svelte";
  let topdata = {
    title: "Setting",
    color: "#1c1b22",
    blur: false,
    blurstrength: 15,
    background: "#313131",
  };
  let categories = ["General", "Electronic", "Food"];
  let currentPage = "General";
</script>

<Apps appname="shop" {topdata} debug={true}>
  <div class="navigation">
    <div class="logo">
      <i class="fa-solid fa-shopping-cart" />
      <span style="margin-left: 5px;">Shop</span>
    </div>
    <div class="nav">
      {#each categories as category (category)}
        <div
          class="navigation-item"
          class:active={currentPage === category}
          on:click={() => {
            currentPage = category;
          }}
        >
          <div
            class="navigation-item-title"
            class:active={currentPage === category}
          >
            {category}
          </div>
        </div>
      {/each}
    </div>
  </div>
  <div class="pages">
    {#if currentPage === "General"}
      Lorem ipsum, dolor sit amet consectetur adipisicing elit. Est quisquam
      aperiam molestias maiores. Sed officia eaque velit atque, nemo dignissimos
      vel deleniti aperiam iure. Mollitia a ut vel. Expedita, minima!
    {/if}
  </div>
</Apps>

<style>
  .pages {
    padding: 30px;
    width: 100%;
    height: 100%;
  }
  .logo {
    font-family: "Noto Sans", sans-serif;
    font-weight: 500;
    gap: 10px;
    width: 50px;
    height: 50px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-left: 70px;
    font-size: 1.5rem;
  }
  .nav {
    font-family: "Noto Sans", sans-serif;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
  }
  .navigation-item-title.active {
    color: #3ab0ff;
    font-weight: 700;
  }
  .navigation-item.active {
    transform: scale(1.3);
  }

  .navigation-item {
    transition: all 0.3s ease;
    display: flex;
    justify-content: center;
    align-items: center;
    min-width: 120px;
    height: 16px;
    padding: 10px;
    font-weight: 600;
    border-radius: 2px;
    font-size: 1rem;
    cursor: pointer;
  }
  .navigation {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    width: 100%;
    height: 80px;

    position: sticky;
    top: 0;
  }
</style>
