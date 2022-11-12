import { writable } from "svelte/store";
import type { IApp } from "../@types/apps";

export interface oldNotificationsType {
  id: number;
  app: IApp;
  message: string;
  timeout?: number;
  addon?: any;
}

function oldNotif() {
  let oldNotification: oldNotificationsType[] = [];
  const _oldNotifications = writable(oldNotification);
  function clear() {
    _oldNotifications.set([]);
  }
  function remove(id: number) {
    _oldNotifications.update((val) => {
      return val.filter((n) => n.id !== id);
    });
  }
  function add(data: oldNotificationsType) {
    _oldNotifications.update((val) => {
      return [data, ...val];
    });
  }
  const { subscribe } = _oldNotifications;
  return {
    clear,
    remove,
    add,
    subscribe,
  };
}

export default oldNotif();
