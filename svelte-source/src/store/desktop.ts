import { writable } from "svelte/store";

export interface appType {
  name: string;
  icon: string;
  text: string;
  color: string;
  background: string;
  isopen: boolean;
  useimage: boolean;
}

interface IOpenedApp {
  name: string;
  component: any;
}

const app: appType[] = [];

export const apps = writable(app);
const openedApps: IOpenedApp[] = [];
export const openedAppStore = writable(openedApps);

export function setApp(data: appType[]) {
  data.sort((a, b) => {
    if (a.name < b.name) {
      return -1;
    }
    if (a.name > b.name) {
      return 1;
    }
    return 0;
  });
  openedAppStore.set([]);
  apps.set(data);
}

export function openApp(data: IOpenedApp) {
  openedAppStore.update((v) => {
    return [...v, data];
  });
}

export function closeApp(name: string) {
  openedAppStore.update((v) => {
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
