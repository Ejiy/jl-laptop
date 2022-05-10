import { writable } from "svelte/store";

const oldNotifications = writable([]);

export default oldNotifications;
