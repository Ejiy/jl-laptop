<script lang="ts">
  import moment from "moment";
  import Apps from "../shared/Apps.svelte";
  import { flip } from "svelte/animate";
  import { fly } from "svelte/transition";
  import Progressbar from "../shared/Progressbar.svelte";
  import { cubicOut } from "svelte/easing";
  import Modal from "../shared/Modal.svelte";
  import { modals } from "../../store/modals";
  import {
    contracts,
    queue,
    started,
    startedContracts,
  } from "../../store/boosting";
  import { notifications } from "../../store/notifications";
  import { fetchNui } from "../../utils/eventHandler";
  let topdata = {
    title: "Car Boosting",
    color: "#2b2d42",
    background: "rgba(50, 48, 60, 0.978)",
    blur: true,
  };
  let pages = ["My Contracts"];

  let activepage = "My Contracts";

  let color: any = {
    ["S+"]: "#ff9800",
    ["D"]: "#4caf50",
  };

  let handleRemove = (id: number) => {
    contracts.update((c) => c.filter((n) => n.id !== id));
    fetchNui("boosting/deny", {
          contractID: id,
    }).then(() => {
        notifications.send("Contract Declined", "boosting", 5000);
    });
  };

  let repConfig: any;
  let repPoint: number;
  let currentRep: string = "D";
  let nextRep: string = "C";
  let progressPercentage: number = 0;

  function getGapPercentage(a: number, b: number) {
    return ((repPoint - b) * 100) / (a - b);
  }

  function getRep() {
    let sorted = repConfig;
    sorted.sort((a: any, b: any) => {
      return b[1] - a[1];
    });
    for (let i = 0; i < sorted.length; i++) {
      if (repPoint >= sorted[i][1]) {
        currentRep = sorted[i][0];
        nextRep = sorted[i - 1][0];
        progressPercentage = getGapPercentage(sorted[i - 1][1], sorted[i][1]);
        break;
      }
    }
  }

  fetchNui("boosting/getcontract").then((r) => {
    console.log(r);
  });

  fetchNui("boosting/setcontract").then((data) => {
    $queue = data
  });


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
        rep: 30,
        repConfig: [
          ["D", 0],
          ["C", 50],
          ["B", 100],
          ["A", 150],
          ["A+", 200],
          ["S", 250],
          ["S+", 300],
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
    let contract = $contracts.find((n) => n.id === id);
    fetchNui("boosting/start", {
      id,
    })
      .then((res) => {
        if (res.status === "success") {
          startedContracts.set([contract as any, ...$startedContracts]);
          started.set(true);
          notifications.send("You just started a contract", "boosting", 5000);
        } else if (res.status === "error") {
          notifications.send(res.message, "boosting", 5000);
        }
      })
      .catch((err) => {
        console.log(err);
        notifications.send(
          "You can't start a contract right now, try again later",
          "boosting",
          5000
        );
      });
  };

  let iswaiting = false;

  let setActivePage = (e: any, page: string) => {
    activepage = page;
  };

  $: {
    console.log($contracts.length, $startedContracts.length);
  }

  function TransferShit(id: number) {
    let contract = $contracts.find((n) => n.id === id);
    modals.show({
      show: true,
      onOk: (value) => {
        if (value) {
          console.log(value);
          fetchNui("boosting/transfer", {
            playerid: value,
            contractID: contract,
          }).then((res) => {
            if (res.status === "success") {
              notifications.send(res.message, "boosting", 5000);
            } else {
              notifications.send(res.message, "boosting", 5000);
            }
          });
        }
      },
      onCancel: () => {},
      title: "Transfer Contract",
      input: true,
      inputPlaceholder: "State ID",
      okText: "Confirm",
      cancelText: "Cancel",
      description: "",
      inputType: "text",
      inputValue: "",
    });
  }
</script>

<Apps {topdata} appname="boosting">
  <div class="boosting">
    <div class="top">
      <div class="navigation">
        {#each pages as page}
          <button
            class:green={page === "My Contracts"}
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
          {#if $contracts.length === 0 && $startedContracts.length === 0}
            <div class="no-contract">You have no contracts</div>
          {/if}
          {#each $startedContracts as started, index (started.id)}
            <div
              class="contract-card"
              out:fly|local={{ duration: 200, x: 300 }}
              animate:flip={{ duration: 300 }}
            >
              <div class="data">
                <div class="first-data">
                  <div class="boost-type">
                    Boost Type : <span style="color: {color[started.contract]};"
                      >{started.contract}</span
                    >
                  </div>
                  <div class="boost-owner">
                    Owner : {started.owner}
                  </div>
                </div>
                <div class="second-data">
                  <div class="vehicle">
                    <p>Vehicle : {started.car}</p>
                    <p>
                      Expires in : <span class="expire">69</span>
                    </p>
                  </div>
                </div>
              </div>
              <div class="control">
                <button
                  class="green started"
                  on:click={() => {
                    startContract(started.id);
                  }}
                >
                  Started
                </button>
              </div>
            </div>
          {/each}
          {#each $contracts as contract (contract.id)}
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
                      Expires in :
                      <span class="expire"
                        >{moment(contract.expire).endOf("hour").fromNow()}</span
                      >
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
                <button class="blue"
                on:click={() => {
                  TransferShit(contract.id);
                }}
                > Transfer Contract </button>
              </div>
            </div>
          {/each}
        </div>
      {/if}
    </div>
  </div>
</Apps>

<style>
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

  .green.started {
    background: #4e5177;
    cursor: not-allowed;
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

    overflow-x: hidden;
  }
  ::-webkit-scrollbar {
    display: none;
  }
</style>
