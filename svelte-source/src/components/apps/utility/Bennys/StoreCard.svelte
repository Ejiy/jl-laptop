<script lang="ts">
  import { createEventDispatcher } from "svelte";
  let dispatch = createEventDispatcher();
  export let name = "";
  export let title = "Dummy";
  export let stock: number = 0;
  export let price: number = 0;
  export let image = "https://cdn3.emoji.gg/emojis/9387-drink-water.png";
  function handleAddCart() {
    dispatch("addCart", {
      name,
      title,
      label: title,
      image: image,
      stock,
      price,
      quantity: 1,
    });
  }
</script>

<div class="store-card">
  <div class="image" style="background-image: url({image});" />
  <div class="product-title">{title}</div>
  <div class="description">
    <span>Stock: <span style="color: green;">{stock}</span></span>
    <span>Price: {price}</span>
  </div>
  <div class="buy">
    <button on:click={handleAddCart}> Add to cart </button>
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

  .image {
    background-position: center;
    background-size: cover;
    background-repeat: no-repeat;
    border-radius: 2px;
    width: 100px;
    height: 100px;
  }
  .store-card {
    font-family: "Bebas Neue", cursive;
    padding: 10px 30px;
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
