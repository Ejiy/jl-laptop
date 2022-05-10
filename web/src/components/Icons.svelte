<script>
    import { apps } from '../store/config'
    import { flip } from 'svelte/animate'
    import { fade } from 'svelte/transition'
    import { createEventDispatcher } from 'svelte'
    const dispatch = createEventDispatcher()
    let openApp = (app) => {
        dispatch('openApp', app)
    }

    let iconExist = async(app) => {
       const image_url = './images/apps/' + app + '.png'
       const image = new Image()
       image.onload = () => {
           return true
       }
       image.onerror = () => {
           return false
      }
      image.src = image_url
      
    }
</script>
<div class="icons">
    {#each $apps as icon (icon.name)}
    <div class="icon" animate:flip="{{duration: 500}}" transition:fade|local>
        <div class="icon-back" style="background-color: {icon.background}" on:click={(e) => {
           openApp(icon.name)
        }}>
        {#if icon.useimage}
            <img src="{'./images/apps/' + icon.name + '.png'}" alt="{icon.name}" class="image" />
        {:else}
             <i class={icon.icon} style="color: {icon.color};"></i>
        {/if}
           
        </div>
        <p class="text">{icon.text}</p>
    </div>
   
    {/each}

</div>

<style>



    .image {
        padding: 5px;
        width: 80%;
        height: 80%;
    }
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