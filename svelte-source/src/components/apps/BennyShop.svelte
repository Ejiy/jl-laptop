<script>
  import Apps from "../../providers/Apps.svelte";
  import { scale } from "svelte/transition";
  import { backOut } from "svelte/easing";
  import StoreCard from "./utility/StoreCard.svelte";
  let topdata = {
    title: "Bennys Shop",
    background: "#1c1b22",
    blur: true,
    blurstrength: 15,
    color: "#1b1b1b",
  };
  let categories = ["Cosmetic Parts", "Performance Parts", "Consumable Parts"];
  let currentPage = "Cosmetic Parts";
  let yes = false;

  setTimeout(() => {
    yes = true;
  }, 1000);

  let numver = 1;

  setInterval(() => {
    if (numver > 10) {
      numver = 1;
    } else {
      numver += 1;
    }
  }, 2000);

  let dummyDatas = [
    {
      name: "Spoiler",
      price: 100,
      stock: 10,
    },
    {
      name: "Front Bumper",
      price: 100,
      stock: 10,
    },
    {
      name: "Rear Bumper",
      price: 100,
      stock: 10,
    },
    {
      name: "Side Skirt",
      price: 100,
      stock: 10,
    },
  ];
</script>

<Apps appname="bennys" {topdata} debug={false}>
  <div class="shop">
    <div class="navigation">
      <div class="left">
        {#each categories as category}
          <button
            class:active={category === currentPage}
            on:click={() => {
              currentPage = category;
            }}
          >
            {category}
          </button>
        {/each}
      </div>
      <div class="right">
        <button>
          <ion-icon name="cart" style="font-size: 20px;" />
          Cart
          {#if yes}
            <div in:scale={{ duration: 300, easing: backOut }} class="circle">
              {numver}
            </div>
          {/if}
        </button>
      </div>
    </div>
    <div class="pages">
      {#if currentPage === "Cosmetic Parts"}
        <div class="cosmetic">
          {#each dummyDatas as data}
            <StoreCard
              title={data.name}
              stock={data.stock}
              price={data.price}
            />
          {/each}
        </div>
      {:else if currentPage === "Performance Parts"}
        <div class="performance">Performance Parts</div>
      {:else if currentPage === "Consumable Parts"}
        <div class="consumable">Consumable Parts</div>
      {/if}
    </div>
  </div>
</Apps>

<style>
  .cosmetic {
    padding: 30px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 0.17fr));
    row-gap: 30px;
    justify-content: flex-start;
    align-items: center;
    width: 100%;
  }
  .pages {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
  }
  .left {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
  }
  .circle {
    padding: 2px;
    font-size: 0.9rem;
    width: 17px;
    height: 17px;
    border-radius: 50%;
    color: #1c1b22;
    background: rgb(255, 255, 255);
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .right button {
    font-weight: 600;
    color: rgb(115, 105, 172);
    gap: 5px;
    width: 100px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgb(37, 37, 37);
  }

  button.active {
    color: rgb(115, 105, 172);
    background: rgb(37, 37, 37);
  }
  button {
    font-weight: 600;
    background: transparent;
    height: 45px;
    color: rgba(148, 148, 148, 0.514);
    border: none;
    padding: 10px;
    border-radius: 30px;
    margin: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
  }
  .navigation {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30px;
  }
  .shop {
    height: 100%;
    font-family: "Bebas Neue", cursive;
    overflow-x: hidden;
  }
</style>
