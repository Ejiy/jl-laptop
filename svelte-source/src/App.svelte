<script lang="ts">
  import VisibilityProvider from "./providers/VisibilityProvider.svelte";
  import Desktop from "./components/base/Desktop.svelte";
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

<VisibilityProvider>
  <Desktop />
</VisibilityProvider>
