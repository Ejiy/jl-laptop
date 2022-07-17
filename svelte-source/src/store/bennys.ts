import { writable } from "svelte/store";
import type { CartItems, Items } from "../@types/bennys";

export const items = writable<Items[]>([]);

export const cart = writable<CartItems[]>([]);
