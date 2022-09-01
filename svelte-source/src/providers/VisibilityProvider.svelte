<script lang="ts">
  import { onMount } from "svelte";
  import { visible, toggleVisible } from "@store/desktop";
  import { fetchNui } from "@utils/eventHandler";

  onMount(() => {
    const keyHandler = (e: KeyboardEvent) => {
      if ($visible && ["Escape"].includes(e.code)) {
        fetchNui("close");
        toggleVisible(false);
      }
    };
    window.addEventListener("keydown", keyHandler);
    return () => window.removeEventListener("keydown", keyHandler);
  });
</script>

<main>
  {#if $visible}
    <slot />
  {/if}
</main>
