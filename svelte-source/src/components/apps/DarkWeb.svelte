<script lang="ts">
  import { notifications } from "@store/notifications";
  import { isEnvBrowser } from "@utils/misc";
  import { fetchNui } from "@utils/eventHandler";

  import type { DarkWebItems } from "../../@types/bennys";
  import { darkwebCartItems, darkwebItems } from "@store/darkweb";
  import Apps from "@shared/Apps.svelte";
  import { onMount } from "svelte";
  let topdata = {
    title: "10.5.51.20/??/?id=9923",
    background: "black",
    blur: true,
    blurstrength: 15,
    color: "rgb(12, 7, 19)",
  };
  let currentPage = "hacking";
  let categories = ["hacking", "guns", "drugs", "cart"];

  function handleAddCart(data: DarkWebItems) {
    if ($darkwebCartItems.find((x) => x.name === data.name)) {
      darkwebCartItems.update((y) => {
        y.find((x) => x.name === data.name).quantity += 1;
        return [...y];
      });
    } else {
      darkwebCartItems.update((y) => [
        {
          category: data.category,
          name: data.name,
          price: data.price,
          quantity: 1,
          label: data.label,
          image: data.image,
          stock: data.stock,
        },
        ...y,
      ]);
    }
  }

  function handleCheckOut() {
    fetchNui("laptop/checkout", {
      cart: $darkwebCartItems,
      app: "darkweb",
    }).then((res) => {
      if (res.status === "success") {
        notifications.send(res.message, "darkweb", 5000);
        darkwebCartItems.set([]);
      } else {
        notifications.send(res.message, "darkweb", 5000);
      }
    });
  }

  function handleRemove(name) {
    darkwebCartItems.set($darkwebCartItems.filter((x) => x.name !== name));
  }

  onMount(() => {
    fetchNui("darkweb/items").then((res) => {
      if (res && res.length > 0) {
        darkwebItems.set(res);
      }
    });
  });
</script>

<Apps {topdata} appname="darkweb">
  <div class="nav-bar">
    <div class="logo">
      <img
        src="https://i.pinimg.com/originals/82/37/e7/8237e7f4fa090020f6d0c2dacc017304.gif"
        alt="something"
      />
    </div>
    <div class="nav-list">
      {#each categories as cat}
        <div
          class:active={cat === currentPage}
          class="nav-item"
          on:click={() => {
            currentPage = cat;
          }}
        >
          {cat.slice(0, 1).toUpperCase() + cat.slice(1)}
        </div>
      {/each}
    </div>
  </div>
  <div class="app-container">
    {#if currentPage !== "cart"}
      <div class="cart-list">
        {#each $darkwebItems as darkwebitem (darkwebitem.name)}
          <div
            class="cart-card"
            class:hide={darkwebitem.category !== currentPage}
          >
            <div class="images">
              <img src={`nui://${darkwebitem.image}`} alt="something" />
            </div>
            <div class="info">
              <div class="title">
                <span>{darkwebitem.label}</span>
              </div>
              <div class="price">
                <span>Price: {darkwebitem.price}</span>
              </div>
              <div class="stock">
                <span>Stock: {darkwebitem.stock}</span>
              </div>
            </div>
            <div class="button">
              <button
                on:click={() => {
                  handleAddCart(darkwebitem);
                }}>Buy</button
              >
            </div>
          </div>
        {/each}
      </div>
    {:else if $darkwebCartItems.length > 0}
      <div class="tables">
        <div class="checkout">
          <button on:click={handleCheckOut}> > > Checkout </button>
        </div>
        <table>
          <tr>
            <th>Item</th>
            <th>Price</th>
            <th>Quantity</th>
            <th />
          </tr>
          {#each $darkwebCartItems as dwitem (dwitem.name)}
            <tr>
              <td>{dwitem.label}</td>
              <td
                >{dwitem.quantity <= 1
                  ? dwitem.price
                  : dwitem.price * dwitem.quantity}</td
              >
              <td>
                <input
                  type="number"
                  bind:value={dwitem.quantity}
                  max={dwitem.stock}
                  min="1"
                />
              </td>
              <td
                on:click={() => {
                  handleRemove(dwitem.name);
                }}>✖</td
              >
            </tr>
          {/each}
          <tr>
            <th>Total</th>
            <td />
            <td />
            <td>
              {$darkwebCartItems.reduce((acc, cur) => {
                return acc + cur.price * cur.quantity;
              }, 0)}
            </td>
          </tr>
        </table>
      </div>
    {:else}
      <div class="empty">
        <span>No items in cart</span>
        <img
          style="width: 150px;"
          src="https://media4.giphy.com/media/xUOxf2ymV1HUI6RYKQ/giphy.gif?cid=6c09b95230dcb411a3b8d42dd8512a433520dc1563b080f2&rid=giphy.gif"
          alt="creppy"
        />
      </div>
    {/if}
  </div>
</Apps>

<style>
  input:focus {
    outline: none;
  }
  input {
    text-align: center;
    background-color: transparent;
    border: none;
    color: white;
    width: 50px;
  }
  .empty {
    color: #fff;
    font-size: 1.5rem;
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  .tables {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }
  tr,
  th,
  td,
  table {
    border: 1px solid white;
  }
  td,
  th {
    padding: 5px;
  }
  table {
    border-spacing: 30px;
    width: 700px;
    border-collapse: collapse;
    text-align: center;
  }
  .title {
    font-size: 1rem;
    font-weight: bold;
    margin: 10px 0;
  }
  .info {
    padding: 10px;
    display: flex;
    flex-direction: column;
    align-items: left;
    justify-content: center;
    height: 100%;
  }
  .button {
    display: flex;
    align-items: flex-end;
    width: 100%;
    height: 100%;
  }
  button {
    background: none;
    color: #fff;
    border: none;
    border-radius: 5px;
    padding: 10px;
    margin: 10px;
    cursor: pointer;
    width: 100%;
    height: 40px;
  }
  .images img {
    width: 100%;
    height: 100%;
  }
  .images {
    width: 100px;
    height: 100px;
  }
  .cart-card.hide {
    display: none;
  }
  .cart-card {
    overflow: hidden;
    display: flex;
    flex-direction: column;
    align-items: center;
    border: 1px solid white;
    width: 200px;
    height: 250px;
  }
  .cart-list {
    padding: 30px;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 0.18fr));
    justify-content: flex-start;
    height: 100%;
  }
  .app-container {
    height: 100%;
    width: 100%;
  }
  .nav-item.active {
    color: blueviolet;
  }
  .nav-list {
    gap: 20px;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
  }
  .nav-bar {
    display: flex;
    justify-content: space-between;
    padding: 0 50px;
  }
  .logo {
    display: flex;
    align-items: center;
    width: 100px;
    height: 100px;
  }
  .logo img {
    width: 100%;
    height: 100%;
  }
</style>
