<script lang="ts">
  import { createEventDispatcher } from "svelte";
  export let title;
  export let quantity;
  export let max;
  export let image = "https://cdn3.emoji.gg/emojis/9387-drink-water.png";
  const dispatch = createEventDispatcher();
  function handleChange(e) {
    dispatch("theChange", e.target.value);
  }
  function handleRemove() {
    dispatch("remove");
  }
</script>

<div class="cart-card">
  <div class="images">
    <img src={image} alt="test" />
  </div>
  <div class="item-title">
    {title}
  </div>
  <div class="quantity">
    <input type="number" value={quantity} {max} on:change={handleChange} />
  </div>
  <div class="button">
    <button on:click={handleRemove}>Remove</button>
  </div>
</div>

<style>
  .quantity {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  .item-title {
    font-size: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  input {
    width: 50px;
    height: 30px;
    outline: none;
    border: none;
    background-color: transparent;
    text-align: center;
    font-size: 20px;
    padding: 0;
    margin: 0;
  }
  button {
    background-color: #b43d3d;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 15px;
    font-weight: bold;
    padding: 6px 12px;
    text-align: center;
    text-decoration: none;
    width: 80px;
    height: 35px;
  }
  .button {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    flex: 4;
    margin-right: 30px;
  }
  .images img {
    width: 100%;
    height: 100%;
  }
  .images {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 70px;
    height: 70px;
  }
  .cart-card {
    height: 100px;
    gap: 30px;
    padding: 10px;
    justify-content: center;
    display: flex;
    align-items: center;
    border-radius: 3px;
    display: flex;
    width: 900px;
    background-color: rgb(37, 37, 37);
  }
</style>
