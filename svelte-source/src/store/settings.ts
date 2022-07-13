import { writable } from "svelte/store";
import type { IDesktopSettings } from "../@types/settings";

export const settings = writable<IDesktopSettings>({
  background:
    "https://i.pinimg.com/originals/67/7d/d0/677dd0ea60b8c98e8ff496449ab65bfe.jpg",
  sound: 0,
  muted: false,
  darkfont: false,
});
