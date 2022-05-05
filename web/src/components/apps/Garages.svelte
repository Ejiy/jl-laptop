<script>
import Apps from "../../shared/Apps.svelte";

    let garagedata = [
        {name: "garage1", address: "123 Main St", text: "Garage 1", icon: "fa-solid fa-car-side", color: "#fff", background: "#494570"},
        {name: "garage2", address: "456 Main St", text: "Garage 2", icon: "fa-solid fa-car-side", color: "#fff", background: "#494570"},
        
    ]
</script>

<Apps title="Garage">
    <div class="garages">
        {#each garagedata as garage (garage.name)}
        <div class="test">
            {garage.name}
        </div>
        {/each}
    </div>
</Apps>

<style>
    .garages {
        width: 100%;
        height: 100%;
        background: rgba(37, 31, 64, 0.978);
        filter: blur();
    }
</style>