import { writable } from "svelte/store";
import type { IDesktopSettings } from "../@types/settings";
import wp1 from "@assets/wallpaper/wp1.png";

export const settings = writable<IDesktopSettings>({
  background: wp1,
  darkfont: false,
});

export function setSettings(data: IDesktopSettings) {
  if (data.background === "default") {
    settings.update((s) => {
      return {
        ...s,
        background: wp1,
      };
    });
  } else {
    settings.set(data);
  }
}
