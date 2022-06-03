<script lang="ts">
  import Apps from "../../providers/Apps.svelte";
  import { flip } from "svelte/animate";
  import { fly } from "svelte/transition";
  import Progressbar from "../../providers/Progressbar.svelte";
  import { cubicOut } from "svelte/easing";
  import Modal from "../../providers/Modal.svelte";
  import {
    contracts,
    saledcontracts,
    queue,
    started,
  } from "../../store/boosting";
  import { notifications } from "../../store/notifications";
  import { fetchNui } from "../../utils/eventHandler";

  let topdata = {
    title: "Car Boosting",
    color: "#2b2d42",
  };

  let pages = ["My Contracts", "Buy Contracts"];

  let activepage = "My Contracts";

  let color: any = {
    ["S+"]: "#ff9800",
    ["D"]: "#4caf50",
  };

  let handleRemove = (id: number) => {
    contracts.update((c) => c.filter((n) => n.id !== id));
  };

  let repConfig: any;
  let repPoint: number;
  let currentRep: string = "D";
  let nextRep: string = "C";
  let progressPercentage: number = 0;

  function getGapPercentage(a: number, b: number) {
    return (a / b) * 100;
  }

  function getRep() {
    let sorted = repConfig;
    sorted.sort((a: any, b: any) => {
      return b[1] - a[1];
    });
    for (let i = 0; i < sorted.length; i++) {
      if (sorted[i][1] <= repPoint) {
        currentRep = sorted[i][0];
        nextRep = sorted[i - 1][0];
        progressPercentage = getGapPercentage(sorted[i][1], sorted[i - 1][1]);
        break;
      }
    }
  }

  fetchNui("boosting/getrep")
    .then((r) => {
      let toarray: any = [];
      for (let i in r.repconfig) {
        toarray.push([i, r.repconfig[i]]);
      }
      repConfig = toarray;
      repPoint = r.rep;
      getRep();
    })
    .catch(() => {
      repConfig = {
        rep: 0,
        repConfig: [
          ["D", 0],
          ["C", 10],
          ["B", 20],
          ["A", 30],
          ["A+", 40],
          ["S", 50],
          ["S+", 0],
        ],
      };
    });

  let joinQueue = () => {
    if (iswaiting) return;
    iswaiting = true;
    setTimeout(() => {
      iswaiting = false;
      $queue = !$queue;
      if ($queue) {
        notifications.send("You have joined the queue", "boosting", 5000);
      } else {
        notifications.send("You have left the queue", "boosting", 5000);
      }
      fetchNui("boosting/queue", {
        status: $queue,
      })
        .then(() => {
          console.log("boosting/queue", $queue);
        })
        .catch((err) => {
          console.log(err);
        });
    }, 2000);
  };

  let startContract = (id: number) => {
    if ($started) return;
    fetchNui("boosting/start", {
      id,
    })
      .then(() => {
        console.log("boosting/start", id);
      })
      .catch((err) => {
        console.log(err);
      });

    fetchNui("boosting/start", {
      id,
    }).catch((e) => console.log(e));

    started.set(true);
    notifications.send("You just started a contract", "boosting", 5000);
  };

  let iswaiting = false;

  let showModal = false;

  let setActivePage = (e: any, page: string) => {
    activepage = page;
  };
</script>

<Apps {topdata} appname="boosting">
  <div class="boosting">
    <Modal shows={showModal}>
      Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium
      maxime magnam eveniet quam dolor labore repellendus. Nam doloribus minima
      quos voluptates, maiores reiciendis laborum, labore quis nostrum magni a
      rem.
    </Modal>
    <div class="top">
      <div class="navigation">
        {#each pages as page}
          <button
            class:green={page === "My Contracts"}
            class:red={page === "Buy Contracts"}
            class:active={page === activepage}
            on:click={(e) => setActivePage(e, page)}>{page}</button
          >
        {/each}
        <button class="blue" on:click={joinQueue} class:disabled={iswaiting}>
          {#if iswaiting}
            <i class="fas fa-regular fa-circle-notch fa-spin" />
          {:else}
            {$queue ? "Leave Queue" : "Join Queue"}
          {/if}
        </button>
      </div>
      <div class="progress">
        <div class="text-pg">
          <h1>{currentRep}</h1>
        </div>
        <Progressbar maxValue={progressPercentage} />
        <div class="text-pg">
          <h1>{nextRep}</h1>
        </div>
      </div>
    </div>
    <div class="body">
      {#if activepage === "My Contracts"}
        <div class="contracts">
          {#each $contracts as contract, index (contract.id)}
            <div
              class="contract-card"
              in:fly|local={{ duration: 300, y: -300, easing: cubicOut }}
              out:fly|local={{ duration: 200, x: 300 }}
              animate:flip={{ duration: 300 }}
            >
              <div class="data">
                <div class="first-data">
                  <div class="boost-type">
                    Boost Type : <span
                      style="color: {color[contract.contract]};"
                      >{contract.contract}</span
                    >
                  </div>
                  <div class="boost-owner">
                    Owner : {contract.owner}
                  </div>
                </div>
                <div class="second-data">
                  <div class="vehicle">
                    <p>Vehicle : {contract.car}</p>
                    <p>
                      Expires in : <span class="expire">{contract.expire}</span>
                    </p>
                  </div>
                </div>
              </div>
              <div class="control">
                <button
                  class="green"
                  class:active={$started}
                  on:click={() => {
                    startContract(contract.id);
                  }}
                >
                  Start Contract
                </button>
                <button
                  class="red"
                  on:click={() => {
                    handleRemove(contract.id);
                  }}
                >
                  Decline Contract
                </button>
                <button class="blue"> Transfer Contract </button>
              </div>
            </div>
          {:else}
            <div class="no-contract">You have no contract</div>
          {/each}
        </div>
      {:else if activepage === "Buy Contracts"}
        <div class="contracts">
          {#each $saledcontracts as contract, index (contract.id)}
            <div
              class="contract-card"
              in:fly|local={{ duration: 300, y: -300, easing: cubicOut }}
              out:fly|local={{ duration: 200, x: 300 }}
              animate:flip={{ duration: 300 }}
            >
              <div class="data">
                <div class="first-data">
                  <div class="boost-type">
                    Boost Type : <span
                      style="color: {color[contract.data.boost.type]};"
                      >{contract.data.boost.type}</span
                    >
                  </div>
                  <div class="boost-owner">
                    Owner : {contract.owner.name}
                  </div>
                </div>
                <div class="second-data">
                  <div class="vehicle">
                    <p>Vehicle : {contract.data.model}</p>
                    <p>
                      Expires in : <span class="expire"
                        >{contract.data.expire}</span
                      >
                    </p>
                    <p>
                      Buy with: <span class="prices">{contract.data.price}</span
                      > Crypto
                    </p>
                  </div>
                </div>
              </div>
              <div class="control">
                <button class="green"> Buy Contract </button>
              </div>
            </div>
          {:else}
            <div class="no-contract">No Contracts</div>
          {/each}
        </div>
      {/if}
    </div>
  </div>
</Apps>

<style>
  .prices {
    color: #ff9800;
  }
  .expire {
    color: #51f8b2;
  }
  .first-data {
    width: 100%;
    height: 100%;
  }

  .text-pg {
    font-family: "Noto Sans", sans-serif;
    font-size: 0.5rem;
    margin: 0 10px;
  }

  .progress {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0 10vw;
  }

  .no-contract {
    font-family: "Noto Sans", sans-serif;
    font-weight: 700;
    text-transform: capitalize;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    font-size: 1.8rem;
    color: #fff;
  }

  .second-data {
    width: 100%;
    height: 100%;
  }

  .contracts {
    margin: 10px;
    padding: 10px 60px;
    box-sizing: border-box;
    overflow-x: hidden;
    overflow-y: auto;
    height: 50vh;
  }

  .data {
    line-height: 30px;
    text-align: left;
    font-family: "Noto Sans", sans-serif;
    font-weight: 600;
    font-size: 18px;
    display: flex;
    justify-content: space-between;
    padding: 30px;
    width: 100%;
    height: 100%;
  }
  .control {
    width: 100%;
    height: 100%;
    display: flex;
    padding: 20px;
  }
  .control button {
    cursor: pointer;
    font-weight: 600;
    font-size: 1rem;
    font-family: "Roboto", sans-serif;
    display: flex;
    justify-content: center;
    text-align: center;
    align-items: center;
    border: none;
    width: 150px;
    height: 35px;
    margin: 6px;
  }
  .contract-card {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 100%;
    max-height: 400px;
    background-color: rgb(50, 56, 77);
    margin: 10px;
  }
  .body {
    margin: 5px;
    padding: 10px 60px;
  }

  .blue.disabled {
    background: #4e5177;
    cursor: not-allowed;
  }
  .green.active {
    background: #266329;
  }

  .red.active {
    background: #913939;
  }
  button.blue {
    background: #6c74cb;
  }

  button.green {
    background: #3c8d40;
  }

  button.red {
    background: #c95959;
  }

  .navigation {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    margin: 20px 30px;
    padding: 0 30px;
  }
  .navigation button {
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: "Roboto", sans-serif;
    font-weight: bold;
    border-radius: 2px;
    font-size: 15px;
    text-align: center;
    font-weight: 600;
    margin: 0px 10px;
    padding: 5px;
    width: 150px;
    height: 35px;
    border: none;
    cursor: pointer;
    text-transform: capitalize;
  }
  .boosting {
    width: 100%;
    height: 100%;
    background: rgba(50, 48, 60, 0.978);
    backdrop-filter: blur(5px);
    overflow-x: hidden;
  }
  ::-webkit-scrollbar {
    display: none;
  }
</style>
