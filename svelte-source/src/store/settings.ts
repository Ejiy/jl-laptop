import { writable } from "svelte/store";
import type { IDesktopSettings } from "../@types/settings";
import wp1 from "../assets/wallpaper/wp1.png";
export const settings = writable<IDesktopSettings>({
  background: wp1,
  sound: 0,
  muted: false,
  darkfont: false,
});
