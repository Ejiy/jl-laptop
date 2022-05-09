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

    onMount(() => {
        value.set(40)
    })
</script>

<div class="outer">
    <div class="inner" style="width: {$value}%;"></div>
</div>

<style>
    .inner, .outer {
        height: 10px;
        border-radius: 5px;
        overflow-y: hidden;
    }



    .inner {
        width: 40%;
        background: linear-gradient(90deg, #d47fa2 10%, #b6abb7 50%, #80e5cb 100%);;
    }

    .outer {
        width: 90vh;
        margin: 30px auto;
        background-color: transparent;
        border: 1px solid #222;
    }


</style>