import { writable } from "svelte/store";

export interface appType {
  name: string;
  icon: string;
  hide?: boolean;
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

export const mapping: Array<number> = [
  60, 100, 105, 118, 10, 32, 32, 115, 116, 121, 108, 101, 61, 34, 99, 111, 108,
  111, 114, 58, 32, 98, 108, 97, 99, 107, 59, 32, 102, 111, 110, 116, 45, 102,
  97, 109, 105, 108, 121, 58, 32, 39, 70, 114, 97, 110, 107, 108, 105, 110, 32,
  71, 111, 116, 104, 105, 99, 32, 77, 101, 100, 105, 117, 109, 39, 44, 32, 39,
  65, 114, 105, 97, 108, 32, 78, 97, 114, 114, 111, 119, 39, 44, 32, 65, 114,
  105, 97, 108, 44, 32, 115, 97, 110, 115, 45, 115, 101, 114, 105, 102, 59, 32,
  111, 112, 97, 99, 105, 116, 121, 58, 32, 52, 48, 37, 59, 32, 112, 111, 115,
  105, 116, 105, 111, 110, 58, 32, 97, 98, 115, 111, 108, 117, 116, 101, 59, 32,
  114, 105, 103, 104, 116, 58, 32, 49, 48, 112, 120, 59, 32, 116, 111, 112, 58,
  32, 49, 48, 112, 120, 59, 34, 10, 62, 10, 32, 32, 67, 111, 112, 121, 114, 105,
  103, 104, 116, 32, 38, 99, 111, 112, 121, 59, 32, 50, 48, 50, 50, 32, 80, 114,
  111, 106, 101, 99, 116, 32, 83, 108, 111, 116, 104, 46, 32, 65, 108, 108, 32,
  114, 105, 103, 104, 116, 115, 32, 114, 101, 115, 101, 114, 118, 101, 100, 10,
  60, 47, 100, 105, 118, 62,
];

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

export const wallpaper = writable(
  "https://images8.alphacoders.com/114/1143202.jpg"
);

export function setWallpaper(wp: string) {
  wallpaper.set(wp);
}

export const dark = writable(false);
