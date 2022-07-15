import { writable } from "svelte/store";
import type { CartItems, Items } from "../@types/bennys";

export const items = writable<Items[]>([
  {
    name: "spoiler",
    label: "Spoiler",
    image: "test",
    price: 100,
    stock: 10,
    category: "Cosmetic Parts",
  },
  {
    name: "front_bumper",
    label: "Front Bumper",
    image: "test",
    price: 100,
    stock: 15,
    category: "Cosmetic Parts",
  },
  {
    name: "rear_bumper",
    label: "Rear Bumper",
    image: "test",
    price: 100,
    stock: 10,
    category: "Cosmetic Parts",
  },
  {
    name: "side_skirt",
    label: "Side Skirt",
    image: "test",
    price: 100,
    stock: 10,
    category: "Cosmetic Parts",
  },
  {
    name: "engine0",
    label: "Stock Engine",
    image: "test",
    price: 100,
    stock: 10,
    category: "Cosmetic Parts",
  },
  {
    name: "engine1",
    label: "Engine Upgrade 1",
    image: "test",
    price: 100,
    stock: 10,
    category: "Cosmetic Parts",
  },
]);

export const cart = writable<CartItems[]>([]);
