<script>
    import { apps } from '../store/config'
    import { flip } from 'svelte/animate'
    import { fade } from 'svelte/transition'
</script>

<div class="icons">
    {#each $apps as icon (icon.name)}
    <div class="icon" animate:flip="{{duration: 500}}" transition:fade>
        <div class="icon-back" style="background-color: {icon.background}" on:click={(e) => {
            // clicked(e, icon)
        }}>
            <i class={icon.icon} style="color: {icon.color};"></i>
        </div>
        <p class="text">{icon.text}</p>
    </div>
   
    {/each}

</div>

<style>
    .text {
        /* color: rgb(255, 255, 255); */
        font-size: 12px;
        font-family: "Segoe UI", sans-serif;
        font-weight: 600;
    }

    .icons {
        display: grid ;
        justify-content: left;
        margin: 10px;
    }

    .sheesh {
        color: rgb(13, 32, 69);
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

    /* make media for 720p */
    @media screen and (max-width: 1280px) {
        .icon-back {
            width: 40px;
            height: 40px;
        }

        i {
            font-size: 15px;
        }
        .text {
            font-size: 10px;
        }
    }

</style>