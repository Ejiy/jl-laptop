import { writable } from "svelte/store";
import type { DarkWebCartItems, DarkWebItems } from "../@types/bennys";

export const darkwebItems = writable<DarkWebItems[]>([
  {
    name: "sus_name",
    label: "Sussy Item",
    image: "https://c.tenor.com/zaWsgPmM9R4AAAAi/sussy-baka.gif",
    category: "hacking",
    price: 10,
    stock: 10,
  },
  {
    name: "sussy",
    label: "Not Sussy Item",
    image:
      "https://cdn.discordapp.com/attachments/995214046414508094/995214463223464036/Comission_Alit_20220204211842.png",
    category: "guns",
    price: 10,
    stock: 10,
  },
]);

export const darkwebCartItems = writable<DarkWebCartItems[]>([]);
