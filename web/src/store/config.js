import { writable } from "svelte/store";

export const config = writable({
  apps: [
    {
      name: "unknown",
      icon: "fa-solid fa-mask",
      text: "Unknown",
      color: "#fff",
      background: "#000",
      isopen: false,
    },
    {
      name: "darkweb",
      icon: "fa-solid fa-user-secret",
      text: "Darkweb",
      color: "#fff",
      background: "rgb(13, 32, 69)",
      isopen: false,
    },
  ],
});

export const apps = writable([
  {
    name: "unknown",
    icon: "fa-solid fa-mask",
    text: "Unknown",
    color: "#fff",
    background: "#000",
  },
  {
    name: "darkweb",
    icon: "fa-solid fa-user-secret",
    text: "Darkweb",
    color: "#fff",
    background: "rgb(13, 32, 69)",
  },
  {
    name: "boosting",
    icon: "fa-solid fa-bolt",
    text: "Boosting",
    color: "#fff",
    background: "rgb(255, 0, 0)",
  },
]);
