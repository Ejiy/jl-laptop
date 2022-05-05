<script>
import Apps from "../../shared/Apps.svelte";

let topdata = {
    title: "Car Boosting",
    color: "#2b2d42",
}

let page = ["boosting", "sales"]

let activepage = "boosting";
    
</script>

<Apps title="Boosting" topdata={topdata}>

    <div class="boosting">
        <div class="navigation">
            <button class="green">
                My Contracts
            </button>
            <button>
                Buy Contracts
            </button>
            <button>
                Join Queue
            </button>
        </div>
        <div class="body">

        </div>
    </div>
</Apps>

<style>

    button.green {
        background: #119917;
    }

    .navigation {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        margin: 20px;
    }
    .navigation button {
        font-family: "Segoe UI", sans-serif;
        border-radius: 2px;
        font-size: medium;
        text-align: center;
        font-weight: 600;
        margin: 0px 10px;
        padding: 5px;
        width: 150px;
        height: 35px;
        border: none;
        cursor: pointer;
    }
    .boosting {
        width: 100%;
        height: 100%;
        background: rgba(50, 48, 60, 0.978);
        backdrop-filter: blur(5px);
    }
</style>