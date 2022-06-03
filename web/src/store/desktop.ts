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

const app: appType[] = [
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
];

export const apps = writable(app);

export const visible = writable(false);

let isvisible: boolean;

const visibleSubscriber = visible.subscribe((value) => (isvisible = value));

export function toggleVisible(status?: boolean) {
  visible.set(status === undefined ? !isvisible : status);
}
