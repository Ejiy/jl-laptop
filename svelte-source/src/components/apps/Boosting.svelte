<script lang="ts">
  import moment from "moment";
  import { modals } from "@store/modals";
  import { flip } from "svelte/animate";
  import {
    canCancel,
    contracts,
    queue,
    startedContracts,
  } from "@store/boosting";
  import { notifications } from "@store/notifications";
  import { fetchNui } from "@utils/eventHandler";

  import Apps from "@shared/Apps.svelte";
  import Progressbar from "@shared/Progressbar.svelte";
  import { quadInOut, quadOut } from "svelte/easing";
  import { onMount } from "svelte";
  import { currentDate } from "@utils/misc";
  import { fade, scale } from "svelte/transition";

  let tierRing = {
    D: "rgb(77, 141, 77)",
    C: "rgb(122, 226, 122)",
    B: "rgb(30, 99, 121)",
    A: "rgb(28, 163, 207)",
    "A+": "rgb(76, 211, 252)",
    S: "rgb(255, 223, 79)",
    "S+": "rgb(255, 208, 0)",
  };

  let iswaiting: boolean;

  let currentPage = "My Contracts";
  let topdata = {
    title: "Car Boosting",
    color: "#1c1b20",
    background: "rgb(22, 20, 31)",
    blur: false,
    blurstrength: 10,
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
        nextRep = sorted[i - 1] ? sorted[i - 1][0] : "MAX";
        progressPercentage = getGapPercentage(
          sorted[i - 1] ? sorted[i - 1][1] : sorted[i][1] + 100,
          sorted[i][1]
        );
        break;
      }
    }
  }

  function handleRemove(id: number) {
    fetchNui("boosting/deny", {
      contractID: id,
    }).then((res) => {
      if (res.status === "success") {
        contracts.update((c) => c.filter((n) => n.id !== id));
      }
      notifications.send(res.message, "boosting", 5000);
    });
  }

  function joinQueue() {
    if (iswaiting) return;
    iswaiting = true;
    setTimeout(() => {
      iswaiting = false;
      fetchNui("boosting/queue", {
        status: !$queue,
      }).then((res) => {
        if (res.status === "success") {
          $queue = !$queue;
        }
        notifications.send(res.message, "boosting", 5000);
      });
    }, 2000);
  }

  function startContract(id: number) {
    if ($startedContracts) return;
    const contract = $contracts.find((c) => c.id === id);
    fetchNui("boosting/start", {
      id,
    })
      .then((res) => {
        if (res.status === "success") {
          startedContracts.set({
            ...contract,
            plate: "",
          });
          canCancel.set(true);
        }
        notifications.send(res.message, "boosting", 5000);
      })
      .catch((err) => {
        notifications.send(
          "You can't start a contract right now, try again later",
          "boosting",
          5000
        );
      });
  }

  function TransferShit(id: number) {
    modals.show({
      show: true,
      onOk: (value) => {
        if (value) {
          fetchNui("boosting/transfer", {
            playerid: value,
            contractID: id,
          }).then((res) => {
            notifications.send(res.message, "boosting", 5000);
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

  function Truncate(text: string) {
    return text.length > 20 ? text.slice(0, 19) + "..." : text;
  }

  function CancelContract(id: number) {
    if (!$canCancel) {
      return notifications.send(
        "You can't cancel the contract",
        "boosting",
        3000
      );
    } else {
      modals.show({
        show: true,
        onOk: () => {
          fetchNui("boosting/cancel", {
            id,
          }).then((res) => {
            if (res == "success") {
              startedContracts.set(null);
              notifications.send(
                "You just cancel your contract",
                "boosting",
                1000
              );
            } else if (res == "failure") {
              notifications.send(
                "You can't cancel the contract",
                "boosting",
                3000
              );
            }
          });
        },
        onCancel: () => {},
        title: "Cancel Contract",
        okText: "Confirm",
        cancelText: "Cancel",
        description:
          "Are you sure you want to cancel this contract?, you will loose it...",
      });
    }
  }

  onMount(() => {
    fetchNui("boosting/getcontract").then((r) => {
      contracts.set(r.contracts);
    });
    fetchNui("boosting/getqueue").then((data) => {
      queue.set(data);
    });

    fetchNui("boosting/getrep").then((r) => {
      let toarray: any = [];
      for (let i in r.repconfig) {
        toarray.push([i, r.repconfig[i]]);
      }
      repConfig = toarray;
      repPoint = r.rep;
      getRep();
    });
  });
</script>

<Apps {topdata} appname="boosting">
  <div class="apps">
    <div class="top">
      <div class="navigation">
        <div class="left">
          <button
            class:active={currentPage === "My Contracts"}
            on:click={() => {
              currentPage = "My Contracts";
            }}>My Contracts</button
          >
        </div>
        <div class="right">
          <button
            on:click={joinQueue}
            class:waiting={iswaiting}
            disabled={iswaiting}
            class:active={$queue}
          >
            {#if iswaiting}
              Please Wait
            {:else}
              {$queue ? "Leave Queue" : "Join Queue"}
            {/if}
          </button>
        </div>
      </div>
      <div class="progbar">
        <div class="currentClass">{currentRep}</div>
        <div class="proggress">
          <Progressbar maxValue={progressPercentage} width={"110vh"} />
        </div>

        <div class="nextClass">{nextRep}</div>
      </div>
    </div>
    <div class="boosting">
      {#if currentPage === "My Contracts"}
        {#if $startedContracts}
          <div class="boosting-card started">
            <div
              class="typeshit"
              class:vin={$startedContracts.type === "vinscratch"}
            >
              {$startedContracts.type === "boosting"
                ? "Boosting Contract"
                : "Vin Contract"}
            </div>
            <div
              class="boost-class"
              style={tierRing[$startedContracts.contract]
                ? "border: 3px solid " + tierRing[$startedContracts.contract]
                : ""}
            >
              {$startedContracts.contract}
            </div>
            <div class="boost-name">{$startedContracts.owner}</div>
            <div class="boost-car">
              {Truncate($startedContracts.carName)}
            </div>
            <div class="plate">
              Plate: <b style="color: gold;"
                >{$startedContracts.plate ?? "Ask JL"}</b
              >
            </div>
            <div class="expires">
              Expires: <b
                >{moment($startedContracts.expire)
                  .endOf("hour")
                  .from(currentDate)}</b
              >
            </div>

            <div class="button started">
              <button
                disabled={!$canCancel}
                on:click={() => CancelContract($startedContracts.id)}
                >Cancel Contract</button
              >
            </div>
          </div>
        {/if}
        {#each $contracts as contract (contract.id)}
          <div
            class="boosting-card"
            animate:flip={{ easing: quadInOut, duration: 240 }}
            in:scale|local={{ duration: 300, easing: quadOut }}
            out:fade|local={{ duration: 200 }}
          >
            <div class="typeshit" class:vin={contract.type === "vinscratch"}>
              {contract.type === "boosting"
                ? "Boosting Contract"
                : "Vin Contract"}
            </div>
            <div
              class="boost-class"
              style={tierRing[contract.contract]
                ? "border: 3px solid " + tierRing[contract.contract]
                : ""}
            >
              {contract.contract}
            </div>
            <div class="boost-name">{contract.owner}</div>
            <div class="boost-car">{Truncate(contract.carName)}</div>
            <div class="boost-reward">Buy In: <b>{contract.cost} GNE</b></div>
            <div class="expires">
              Expires: <b
                >{moment(contract.expire).endOf("hour").from(currentDate)}</b
              >
            </div>
            <div class="button">
              <button
                on:click={() => [startContract(contract.id)]}
                disabled={$startedContracts !== null}>Start Contract</button
              >
              <button
                on:click={() => [TransferShit(contract.id)]}
                disabled={$startedContracts !== null}>Transfer Contract</button
              >
              <button
                disabled={$startedContracts !== null}
                on:click={() => {
                  handleRemove(contract.id);
                }}>Decline Contract</button
              >
            </div>
          </div>
        {/each}
        {#if $contracts.length === 0 && !$startedContracts}
          <div class="no-contract">
            <div class="title">You have no contracts</div>
          </div>
        {/if}
      {/if}
    </div>
  </div>
</Apps>

<style>
  .typeshit.vin {
    background: rgb(45, 39, 126);
  }
  .typeshit {
    height: 25px;
    width: 100%;
    font-size: 1rem;
    font-weight: bold;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgb(65, 60, 131);
  }
  .apps {
    overflow: hidden;
    height: 100%;
  }

  .no-contract .title {
    font-size: 2.5rem;
    font-weight: bold;
    color: #fff;
    text-align: center;
  }
  .no-contract {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .boosting::-webkit-scrollbar {
    display: none;
  }
  .boosting {
    padding: 20px;
    display: grid;
    justify-content: center;
    grid-template-columns: repeat(auto-fit, minmax(250px, 0.1fr));
    gap: 15px;
    height: 100%;
    overflow-x: hidden !important;
  }
  .boost-reward,
  .expires {
    font-size: 15px;
    color: #fff;
  }
  .boost-car {
    font-size: 1rem;
    font-weight: bold;
  }
  .boost-name {
    margin-top: 30px;
    font-size: 1.2rem;
    font-weight: bold;
  }
  .boost-class {
    margin-top: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 50px;
    font-weight: bold;
    width: 100px;
    height: 100px;
    border-radius: 50%;
    border: 3px solid rgb(76, 211, 252);
    background: #241f35;
  }

  .button button {
    background-color: rgb(22, 20, 31);
    width: 170px;
    height: 50px;
    padding: 10px;
    border-radius: 5px;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .button.started {
    margin-top: 30px;
    height: 170px;
    justify-content: flex-end;
  }
  .button {
    margin-top: 5px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    justify-content: center;
    align-items: center;
  }
  .boosting-card.started {
    border: 1px solid rgb(29, 39, 124);
  }

  .boosting-card {
    border-radius: 5px;
    overflow: hidden;

    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
    width: 230px;
    height: 500px;
    background-color: rgb(18, 16, 24);
  }
  .left,
  .right {
    font-size: 30px;
    gap: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  button.active {
    color: rgb(41, 141, 255);
  }
  button.waiting {
    cursor: not-allowed;
  }
  button {
    color: rgba(255, 255, 255, 0.377);
    letter-spacing: 2px;
    font-weight: bold;
    cursor: pointer;
    font-size: 0.8rem;
    text-transform: uppercase;
    border: none;
    background: transparent;
  }
  .currentClass,
  .nextClass {
    font-size: 15px;
    font-weight: bold;
    color: #fff;
    text-align: center;
    display: flex;
    align-items: center;
  }
  .navigation {
    width: 100%;
    display: flex;
    margin-top: 10px;
    justify-content: space-between;
    align-items: center;
    padding: 10px 100px;
  }
  .proggress {
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .progbar {
    gap: 20px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .top {
    margin-top: 10px;
    display: flex;
    align-items: center;
    flex-direction: column;
  }

  * {
    font-family: "Noto Sans", sans-serif;
  }
</style>
