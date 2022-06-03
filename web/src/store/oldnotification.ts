import { writable } from "svelte/store";
import type { appType } from "./desktop";

export interface oldNotificationsType {
  id: number;
  app: appType;
  message: string;
  timeout?: number;
}

let oldNotification: oldNotificationsType[] = [];

let oldNotifications = writable(oldNotification);

export default oldNotifications;
