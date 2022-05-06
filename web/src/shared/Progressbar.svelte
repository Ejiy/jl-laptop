<script>
    import { tweened } from 'svelte/motion'
    import { cubicOut } from 'svelte/easing'
import { onMount } from 'svelte';
    export let value = tweened(0, {
        duration: 2000,
        easing: cubicOut,

    })
    let update = (e) => {
        value.set($value + 50)
    }

    $: {
        console.log($value)
    }
    onMount(() => {
        value.set(40)
    })
</script>

<div class="outer">
    <div class="inner" style="width: {$value}%;"></div>
</div>

<style>
    .inner, .outer {
        height: 15px;
        border-radius: 5px;
    }

    .inner {
        width: 40%;
        background: linear-gradient(90deg, #d53369 0%, #daae51 100%);;
    }

    .outer {
        width: 90vh;
        margin: 30px auto;
        background-color: #fff;
        border: 1px solid #222;
    }


</style>