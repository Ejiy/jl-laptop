<script>
import { text } from 'svelte/internal';

    // export let icons
    import { config } from '../config'
    console.log(config.subscribe(v => v.apps))
    let icons = [
        {
            name: "garage",
            icon: "fa-solid fa-warehouse",
            text: "Garage App",
            color: "#fff",
            background: "#494570",
        },
        {
            name: "unknown",
            icon: "fa-solid fa-mask",
            text: "Unknown",
            color: "#fff",
            background: "#000",
        },


    ]
    console.log(icons)
    let clicked = (e, data) => {
        console.log('clicked')
    }
</script>

<div class="icons">
    {#each icons as icon (icon.name)}
    <div class="icon">
        <div class="icon-back" style="color: {icon.color}; background-color: {icon.background}" on:click={(e) => {
            clicked(e, icon)
        }}>
            <i class={icon.icon}></i>
        </div>
        <p class="text">{icon.text}</p>
    </div>
   
    {/each}

</div>

<style>
    .text {
        color: rgb(255, 255, 255);
        font-size: 12px;
        font-family: "Segoe UI", sans-serif;
        font-weight: bold;
    }
    .icons {
        display: grid ;
        justify-content: left;
        margin: 10px;
    }

    i {
        font-size: 20px;
    }

    .icon {
        /* make it center */
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .icon-back {
        width: 50px;
        height: 50px;
        /* background-color: rgb(0, 0, 0); */
        border-radius: 6px;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 10px;
        cursor: pointer;
    }

</style>