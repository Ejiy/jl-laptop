<script>
    import { fade, fly, scale } from 'svelte/transition';
    import {cubicIn, cubicInOut, cubicOut, elasticOut} from "svelte/easing";
    export let shows = false
    let toggle = () => {
        shows = !shows
    }
    export let closebutton = true
    export let title = "Modal"
</script>

{#if shows}
<div class="modal-wrapper" transition:fade|local="{{duration: 500}}">
    <div class="modal" in:fly|local="{{ duration: 600, easing: cubicOut, y: 300}}" out:fly|local="{{duration: 400, easing: cubicInOut}}">
        {#if closebutton}
        <div class="top">
            <div class="title" style="float: left;">
                {title}
            </div>
            <div class="close" style="float: right;">
                <i class="fa-solid fa-circle-xmark" style="color: rgb(245, 105, 105); font-size: 15px;" on:click={toggle}></i>
            </div>
        </div>
        {/if}
        <div class="modal-c">
            <slot></slot>
        </div>
    </div>
</div>
{/if}
<style>
    .top {
        padding: 3px 5px;
        display: flex;
        justify-content: space-between;
    }
    .title {
        font-size: 15px;
        font-weight: bold;
        font-family: "Segoe UI", sans-serif;
    }
    .modal-c {
        font-family: "Segoe UI", sans-serif;
        font-size: .95rem;
        padding: 10px;
    }
    .modal-wrapper {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
    }
    .modal {
        position: absolute;
        padding: 5px;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        min-width: 300px;
        min-height: 200px;
        background-color: rgb(50, 56, 77);
        border-radius: 6px;
    }
</style>