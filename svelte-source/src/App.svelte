<script lang="ts">
  import VisibilityProvider from "./providers/VisibilityProvider.svelte";
  import Desktop from "./components/Desktop.svelte";
  import { debugData } from "./utils/debugData";
  import { handlerMessage } from "./utils/eventHandler";

  handlerMessage();
  debugData([
    {
      action: "toggle",
      data: false,
    },
  ]);
</script>

<main>
  <VisibilityProvider>
    <Desktop />
  </VisibilityProvider>
</main>
