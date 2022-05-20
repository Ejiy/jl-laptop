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
    name: "boosting",
    icon: "fa-solid fa-bolt",
    text: "Boosting",
    color: "#fff",
    background: "#1d2029",
    isopen: false,
    useimage: true,
  },
  {
    name: "shop",
    icon: "fa-solid fa-shopping-cart",
    text: "Shop",
    color: "#fff",
    background: "#cc6c6e",
    isopen: false,
    useimage: false,
  },
  {
    name: "browser",
    icon: "fa-solid fa-globe",
    text: "Browser",
    color: "#fff",
    background: "#aa2e25",
    isopen: false,
    useimage: false,
  },
]);
