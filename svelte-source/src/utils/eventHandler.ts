import { onMount, onDestroy } from "svelte";
import { handleContracts, started, startedContracts } from "../store/boosting";
import { toggleVisible } from "../store/desktop";
import { notifications } from "../store/notifications";

interface nuiMessage {
  data: {
    action: string;
    [key: string]: any;
  };
}

export async function fetchNui<T = any>(
  eventName: string,
  data: unknown = {}
): Promise<T> {
  const options = {
    method: "post",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify(data),
  };
  const resourceName = "ps-laptop";
  const resp = await fetch(`https://${resourceName}/${eventName}`, options);
  return await resp.json();
}

export function handlerMessage() {
  function Event(event: nuiMessage) {
    switch (event.data.action) {
      case "toggle":
        toggleVisible(event.data?.status);
        break;
      case "receivecontracts":
        handleContracts(event.data?.contracts);
        break;
      case "booting/delivered":
        startedContracts.set([]);
        started.set(false);
        notifications.send("You have completed the contact", "boosting", 5000);
        break;
    }
  }
  onMount(() => window.addEventListener("message", Event));
  onDestroy(() => window.removeEventListener("message", Event));
}
