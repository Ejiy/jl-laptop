import { writable } from "svelte/store";
import type { BennysItem, BennysCartItems } from "../@types/bennys";

export const items = writable<BennysItem[]>([]);

export const cart = writable<BennysCartItems[]>([]);
