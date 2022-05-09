<script>
import Apps from "../../shared/Apps.svelte";
import { flip } from 'svelte/animate'
import { fade, slide, scale, fly } from 'svelte/transition'
import Progressbar from "../../shared/Progressbar.svelte";
import { cubicIn, cubicInOut, cubicOut } from "svelte/easing";
import Modal from "../../shared/Modal.svelte";
let topdata = {
    title: "Car Boosting",
    color: "#2b2d42",
}


let joinqueue = false

let pages = ["My Contracts", "Buy Contracts"]

let activepage = "My Contracts";

let myContract = [
    {id: 1, name: "TustJazzy", data: {
        vehicle: "Lamborghini",
        model: "Aventador",
        plate: "ABC123",
        price: "1000000",
        expire: "6 hours",
        boost: {
            type: "S+"
        }
    }, owner: {
        name: "John Doe 1",
        phone: "123456789",
    }},
    {id: 2, name: "TustJazzy", data: {
        vehicle: "Lamborghini",
        model: "Aventador",
        plate: "ABC123",
        price: "1000000",
        expire: "3 hours",
        boost: {
            type: "S+"
        }
    }, owner: {
        name: "John Doe 2",
        phone: "123456789",
    }},
]

let salesContract = [
    {id: 3, name: "Yee", data: {
        vehicle: "Royroysd",
        model: "Aventador",
        plate: "ABC123",
        price: "1000000",
        expire: "2021-01-01",
        boost: {
            type: "S+"
        }
    }, owner: {
        name: "Not Koil",
        phone: "123456789",
    }},
    {id: 6, name: "DW", data: {
        vehicle: "Lamborghini",
        model: "Aventador",
        plate: "ABC123",
        price: "1000000",
        expire: "2021-01-01",
        boost: {
            type: "S+"
        }
    }, owner: {
        name: "Treyy 😎",
        phone: "123456789",
    }},
]

let addSomething = () => {
    myContract = [
        {
            id: 3,
            name: "TustJazzy",
            data: {
                vehicle: "Lamborghini",
                model: "Aventador",
                plate: "ABC123",
                price: "1000000",
                expire: "2021-01-01",
                boost: {
                    type: "S+"
                }
            },
            owner: {
                name: "John Doe 3",
                phone: "123456789",
            }
        }, ...myContract
    ]
}
let handleRemove = (e, id) => {
   myContract = myContract.filter((c) => c.id !== id)
}

let joinQueue = () => {
    joinqueue = !joinqueue
}

let showModal = false

let toggleModal = () => {
    showModal = !showModal
}
    
let setActivePage = (e, page) => {
    activepage = page
}
</script>

<Apps title="Boosting" topdata={topdata}>

    <div class="boosting">
        <Modal shows={showModal}>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium maxime magnam eveniet quam dolor labore repellendus. Nam doloribus minima quos voluptates, maiores reiciendis laborum, labore quis nostrum magni a rem.
        </Modal>
        <div class="top">
            <div class="navigation">
                <button class="green">
                    My Contracts
                </button>
                <button class="blue" on:click={joinQueue} class:disabled={joinqueue}>
                    {joinqueue ? "Leave Queue" : "Join Queue"}
                </button>
                <button class="blue" on:click={addSomething}>
                    Add something
                </button>
                <button class="blue" on:click={toggleModal}>
                    Toggle modals
                </button>
            </div>
            <div class="progress">
                <div class="text-pg">
                    <h1>A</h1>
                </div>
                <Progressbar/>
                <div class="text-pg">
                    <h1>B</h1>
                </div>
            </div>
        </div>
        <div class="body" >
            <div class="contracts"  >
                {#each myContract as contract, index (contract.id)}
                <div class="contract-card" in:fly="{{duration: 300, y: -300, easing: cubicOut}}" out:fly|local="{{duration: 200, x: 300}}" animate:flip={{duration: 300}}>
                    <div class="data">
                        <div class="first-data">
                            <div class="boost-type">
                                Boost Type : {contract.data.boost.type}
                            </div>
                            <div class="boost-owner">
                                Owner : {contract.owner.name}
                            </div>
                        </div>
                        <div class="second-data">
                            <div class="vehicle">
                                <p>Vehicle : {contract.data.model}</p>
                                <p>Expires in : <span class="expire">{contract.data.expire}</span></p>
                            </div>
                        </div>
                    </div>
                    <div class="control">
                        <button class="green">
                            Start Contract
                        </button>
                        <button class="red" on:click={(e) => {
                            handleRemove(e, contract.id)
                        }}>
                            Decline Contract
                        </button>
                        <button class="blue">
                            Transfer Contract
                        </button>
                    </div>
                </div>
                {:else}
                <div class="no-contract">
                    You have no contract
                </div>
                {/each}
            </div>
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
        font-size: .5rem
    }

    .progress {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 0 10vw;
    }

    .blue.waiting {
        background-color: #51f8b2;
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
        justify-content: flex-start;
        align-items: center;
        margin: 20px 30px;
        padding: 0 30px;
    }
    .navigation button {
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: 'Roboto', sans-serif;
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