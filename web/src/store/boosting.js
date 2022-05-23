import { writable } from "svelte/store";

export const contracts = writable([]);

export const queue = writable(false);

export const started = writable(false);

export const saledcontracts = writable([
  {
    id: 3,
    name: "Jayce",

    data: {
      vehicle: "Lamborghini",
      model: "Aventador",
      plate: "ABC123",
      price: 320,
      expire: "3 hours",
      boost: {
        type: "S+",
      },
    },
    owner: {
      name: "Not me",
      phone: "123456789",
    },
  },
]);
