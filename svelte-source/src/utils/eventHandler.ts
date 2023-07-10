import { onMount, onDestroy } from "svelte";
import {
  canCancel,
  handleContracts,
  started,
  startedContracts,
} from "@store/boosting";
import { toggleVisible } from "@store/desktop";
import { notifications } from "@store/notifications";
import { setCurrentDate } from "./misc";

interface nuiMessage {
  data: {
    action: string;
    [key: string]: any;
  };
}

/**
 * It sends a POST request to the NUI resource with the specified event name and data, and returns the
 * response as a JSON object
 * @param {string} eventName - The name of the event you want to send to the NUI.
 * @param {unknown} data - The data you want to send to the NUI.
 * @returns The return value is a Promise that resolves to the JSON-decoded response body.
 */

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
  const resourceName = "jl-laptop";
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
        setCurrentDate(event.data?.serverdate);
        break;
      case "booting/delivered":
        startedContracts.set(null);
        notifications.send("You have completed the contact", "boosting", 5000);
        break;
      case "boosting/horseboosting":
        setTimeout(() => {
          startedContracts.update((segs) => {
            segs.plate = event.data?.data.plate;
            return segs;
          });
        }, 500);
        break;
      case "custom-notif":
        notifications.send(
          event.data.data.text,
          undefined,
          event.data.data.length ?? 3000,
          {
            background: event.data.data.background,
            icon: event.data.data.icon,
            color: event.data.data.color,
          }
        );
        break;
      case "boosting/setcancel":
        canCancel.set(event.data.data.status);
        break;
    }
  }
  onMount(() => window.addEventListener("message", Event));
  onDestroy(() => window.removeEventListener("message", Event));
}
