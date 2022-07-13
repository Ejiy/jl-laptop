import type { IApp, IOpenedApp } from "../@types/apps";
import { writable } from "svelte/store";

export const apps = writable<IApp[]>([]);

export const openedApps = writable<IOpenedApp[]>([]);

export function setApp(data: IApp[]) {
  data.sort((a, b) => {
    if (a.name < b.name) {
      return -1;
    }
    if (a.name > b.name) {
      return 1;
    }
    return 0;
  });
  openedApps.set([]);
  apps.set(data);
}

export function openApp(data: IOpenedApp) {
  openedApps.update((v) => {
    return [...v, data];
  });
}

export function closeApp(name: string) {
  openedApps.update((v) => {
    const filter = v.filter((v) => v.name !== name);
    return [...filter];
  });
}

export const visible = writable(false);

let isvisible: boolean;

const visibleSubscriber = visible.subscribe((value) => (isvisible = value));

export function toggleVisible(status?: boolean) {
  visible.set(status === undefined ? !isvisible : status);
}
