<script lang="ts">
  export let title = "Dummy";
  export let stock: number = 0;
  export let price: number = 0;
</script>

<div class="store-card">
  <div class="image">
    <img src="https://cdn3.emoji.gg/emojis/6976-love-panic.png" alt="lorem" />
  </div>
  <div class="product-title">{title}</div>
  <div class="description">
    <span>Stock: <span style="color: green;">{stock}</span></span>
    <span>Price: {price}</span>
  </div>
  <div class="buy">
    <button> Add to cart </button>
  </div>
</div>

<style>
  .description {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: left;
  }
  .buy {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 10px;
    flex: 4;
  }
  .product-title {
    font-size: 1.3rem;
    margin-top: 30px;
    margin-bottom: 0.5rem;
  }
  img {
    width: 100%;
    height: 100%;
  }
  .image {
    width: 100px;
    height: 100px;
  }
  .store-card {
    font-family: "Bebas Neue", cursive;
    padding: 30px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    width: 200px;
    height: 290px;
    overflow: hidden;
    background-color: rgb(37, 37, 37);
    border-radius: 5px;
  }
  button {
    color: white;
    border: none;
    width: 90px;
    height: 30px;
    border-radius: 30px;
    background-color: rgb(87, 64, 172);
    cursor: pointer;
  }
</style>
