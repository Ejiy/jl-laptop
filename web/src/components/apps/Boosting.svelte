<script>
import Apps from "../../shared/Apps.svelte";
import { flip } from 'svelte/animate'
import { fade, slide, scale, fly } from 'svelte/transition'
import Progressbar from "../../shared/Progressbar.svelte";
import { cubicIn, cubicInOut, cubicOut } from "svelte/easing";
let topdata = {
    title: "Car Boosting",
    color: "#2b2d42",
}




let pages = ["My Contracts", "Buy Contracts"]

let activepage = "My Contracts";

let myContract = [
    {id: 1, name: "TustJazzy", data: {
        vehicle: "Lamborghini",
        model: "Aventador",
        plate: "ABC123",
        price: "1000000",
        expire: "2021-01-01",
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
        expire: "2021-01-01",
        boost: {
            type: "S+"
        }
    }, owner: {
        name: "John Doe 2",
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
    
let setActivePage = (e, page) => {
    activepage = page
}
</script>

<Apps title="Boosting" topdata={topdata}>

    <div class="boosting">
        <div class="navigation">
            <!-- <button class="green">
                My Contracts
            </button>
            <button>
                Buy Contracts
            </button> -->
            {#each pages as page}
                <button class="{page === 'My Contracts' ? 'green' : ''} {page === 'Buy Contracts' ? 'red' : ''}" class:active={page === activepage} on:click={(e) => {
                    setActivePage(e, page)
                }}>
                    {page}
                </button>
            {/each}
            <button class="blue">
                Join Queue
            </button>
            <button class="blue" on:click={addSomething}>
                Add something
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
        <div class="body" >
            {#if activepage == "My Contracts"}
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
                                <p>Expire : {contract.data.expire}</p>
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
                            Delete Contract
                        </button>
                        <button class="blue disabled">
                            Sell Contract
                        </button>
                    </div>
                </div>
                {:else}
                <div class="no-contract">
                    You have no contract
                </div>
                {/each}
            </div>
            {:else if activepage == "Buy Contracts"}
            <div class="sales" >
                <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Vel rem similique, sunt voluptates voluptatum libero enim pariatur ducimus sapiente facilis dolores, architecto qui harum sed nulla dignissimos quae consequuntur veniam.</p>
            </div>
            {/if}
        </div>
    </div>
</Apps>

<style>

    
    .contracts {
        margin: 10px;
        padding: 10px 60px;
        box-sizing: border-box;
        overflow-x: hidden;
        overflow-y: auto;
    }
    .first-data {
        width: 100%;
        height: 100%;
    }

    .text-pg {
        font-family: "Roboto", sans-serif;
        font-size: .5rem
    }

    .progress {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 0 10vw;
    }

    .no-contract {
        /* padding-top: 30px; */
        font-family: "Roboto", sans-serif;
        font-weight: 700;
        text-transform: capitalize;
        padding: 50px;
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 1.8rem;
        color: #fff;
    }

    .second-data {
        width: 100%;
        height: 100%;
    }

    .data {
        line-height: 30px;
        text-align: left;
        font-family: "Roboto", sans-serif;
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

    /* .body {
    
        margin: 10px;
        padding: 10px 60px;
        box-sizing: border-box;
        overflow-x: hidden;
        overflow-y: auto;
    } */

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
    }
</style>