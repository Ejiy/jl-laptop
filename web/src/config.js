import { writable } from "svelte/store";

export const config = writable({
  apps: {},
});

export const app = writable({
  name: "",
});
