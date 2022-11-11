<script lang="ts">
  import VisibilityProvider from "./providers/VisibilityProvider.svelte";
  import Desktop from "./components/base/Desktop.svelte";
  import { debugData } from "./utils/debugData";
  import { fetchNui, handlerMessage } from "./utils/eventHandler";
  import { onMount } from "svelte";

  handlerMessage();
  debugData([
    {
      action: "toggle",
      data: false,
    },
  ]);

  onMount(() => {
    fetchNui("loaded");
  });
</script>

<VisibilityProvider>
  <Desktop />
</VisibilityProvider>
