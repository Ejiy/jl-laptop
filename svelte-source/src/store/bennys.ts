import { writable } from "svelte/store";
import type { BennysItem, BennysCartItems } from "../@types/bennys";

export const items = writable<BennysItem[]>([
  {
    name: "Coca-Cola",
    price: 300,
    image:
      "https://images.tokopedia.net/img/cache/500-square/VqbcmM/2020/9/16/09b4e6e5-53c9-49ca-86d3-96d7815d3f65.jpg",
    stock: 100,
    category: "Consumable Parts",
    label: "Coca-Cola",
  },
  {
    name: "Pepsi",
    price: 300,
    image:
      "https://awsimages.detik.net.id/community/media/visual/2019/02/13/9dfb225a-637b-46e2-beb7-a31cab0553d2.jpeg",
    stock: 100,
    label: "Fanta",
    category: "Consumable Parts",
  },
]);

export const cart = writable<BennysCartItems[]>([]);
