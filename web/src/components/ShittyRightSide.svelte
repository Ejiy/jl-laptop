<script>


     import { fade } from 'svelte/transition'
     export let showRightside = true
     let notifications = [
        //  {text: 'Test 1', icon: 'fa-solid fa-car-side', color: '#fff', background: '#494570'},
     ]

     let foo = () => {
        console.log('foo')
     }
</script>

{#if showRightside}                       
<div class="right-side" transition:fade="{{duration:100}}">
    <div class="controls">
        <div class="title">               
            Notifications
        </div>
        {#if notifications.length > 0}                                
        <button class="clear" on:click={foo}>
            Clear all
        </button>
        {/if}
      
    </div>
    <div class="notifications">
        
        {#each notifications as notificaton }
            <div class="notif">
                <div class="icon">
                    <i class={notificaton.icon}></i>
                </div>
            </div>
            {:else}
            <div class="error-notif">
                <div class="error-text">
                    No notifications
                </div>
            </div>
        {/each}
    
    </div>
</div>
{/if}
<style>
    .error-notif {
        font-family: "Segoe UI", sans-serif;
        position: absolute;
        top: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        width: 100%;
    }
    .notif {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        background: rgba(37, 31, 64, 0.978);
        backdrop-filter: blur(10px);
    }

    button.clear {
        background: #494570;
        color: #fff;
        border: none;
        padding: 5px;
        font-size: 12px;
        font-family: "Segoe UI", sans-serif;
        background: rgba(75, 77, 91, 0.508);
        border-radius: 3px;
        min-width: 60px;
        cursor: pointer;
    }
    .right-side {
        margin-right: 10px;
        position: absolute;
        top: 50%;
        right: 0;
		transform: translate(0, -50%);
        border-radius: 5px;
        min-width: 300px;
        max-width: 600px;
        height: 90%;
        background: rgba(75, 77, 91, 0.508);
        backdrop-filter: blur(10px);
    }
    .notifications {
        margin-top: 20%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: safe;
        width: 100%;
        height: 100%;
        overflow-y: auto;
        overflow-x: hidden;
        /* background-color: #494570; */
    }
    /* make media for 720p screen */
    @media screen and (max-width: 1280px) {
        .right-side {
            height: 80%;
            min-width: 280px;
        }
     /* @media only screen and (max-width: px) {
        .right-side {
            position: absolute;
            top: 50%;
            right: 0;
            transform: translate(0, -50%);
            border-radius: 5px;
            min-width: 300px;
            max-width: 600px;
            height: 70%;
            background: rgba(0, 30, 255, 0.508);
            backdrop-filter: blur(10px);
        } */
    }
    .title {
        font-family: "Segoe UI", sans-serif;
        font-size: 15px;
        font-weight: bold;

    }
    .controls {
        position: absolute;
        padding: 10px;
        top: 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: rgba(19, 21, 36, 0.508);
        width: 100%;
        height: 40px;
        z-index: 10;
    }
</style>