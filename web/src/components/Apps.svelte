<script>
    import Garages from './apps/Garages.svelte';
    import { config } from '../config'
    import { fade } from 'svelte/transition'
    let app = ['garages']
    let activeapp = 'garages'
    let moving = false
    let showapp = false
    export let left = 100
    export let top = 100
    $ :{
        // console.log(left)
        // console.log(top)
    }
    function onMouseDown() {
        moving = true
    }

    function onMouseMove(e) {
      
        if (moving) {
            console.log(e)
            left += e.movementX
            top += e.movementY
        }
    }

    function onMouseUp() {
        moving = false
    }

    function SHOW() {
        showapp = !showapp
    }
    // console.log(appdata)
</script>
<button on:click={SHOW}>TEST</button>
{#if showapp}

<div class="apps" style="left: {left}; top: {top};"  transition:fade="{{duration: 100}}">
    <div class="actual-app">
        <div class="top {moving ? 'ondrag' : ''}" on:mousedown={onMouseDown}>
            <div class="title">
                <span class="title-text">Garages</span>
            </div>
            <div class="controls">
                <div class="exit" on:click={SHOW}>
                    <i class="fa-solid fa-circle-xmark" style="color: rgb(245, 105, 105); font-size: 15px;"></i>
                </div>
            </div>
        </div>
        <!-- {#if  app['garages']} -->
        <Garages/>
        <!-- {/if} -->
    </div>
</div>
{/if}
<svelte:window on:mouseup={onMouseUp} on:mousemove={onMouseMove} />
<style>

    .title-text {
        font-size: 15px;
        font-weight: bold;
        font-family: "Segoe UI", sans-serif;
    }
    .apps {
        border-radius: 2px;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 70%;
        height: 70%;
    }

    .ondrag {
        cursor: move;

    }
    .actual-app {
        width: 100%;
        height: 100%;
        /* background: rgba(37, 31, 64, 0.978);
        filter: blur(); */
    }

    .top {
        
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 15px;
        width: 100%;
        height: 30px;
        background: rgba(20, 14, 49, 0.978);
        filter: blur();
    }

    .exit {
        width: max-content;
        height: max-content;
        cursor: pointer;
    }
</style>