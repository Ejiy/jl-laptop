<script>
    import { fade } from 'svelte/transition'
    let moving = false
    export let showapp = true
    export let left = 100
    export let top = 100
    export let topdata = {
        title: "Unknown",
        color: "#fff",
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
</script>
{#if showapp}
<div class="apps" style="left: {left}; top: {top};"  transition:fade="{{duration: 100}}">
    <div class="actual-app">
        <div class="top {moving ? 'ondrag' : ''}" on:mousedown={onMouseDown} style="background: {topdata.color};">
            <div class="title">
                <span class="title-text">{topdata.title}</span>
            </div>
            <div class="controls">
                <div class="exit" on:click={SHOW}>
                    <i class="fa-solid fa-circle-xmark" style="color: rgb(245, 105, 105); font-size: 15px;"></i>
                </div>
            </div>
         
        </div>
        <slot></slot>
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
        border-radius: 6px;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    .ondrag {
        cursor: move;

    }
    .actual-app {
        width: 100%;
        height: 100%;
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        background: rgba(50, 48, 60, 0.978);
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
        backdrop-filter: blur(10px);
    }

    .exit {
        width: max-content;
        height: max-content;
        cursor: pointer;
    }
</style>