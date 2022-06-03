<script>
  import Apps from "../../providers/Apps.svelte";

  let topdata = {
    title: "Browser",
    color: "#1d2029",
  };
</script>

<Apps {topdata} appname="browser">
  <div class="body">TEST</div>
</Apps>
