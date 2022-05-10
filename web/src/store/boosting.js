import { writable } from "svelte/store";

export const contracts = writable([
  {
    id: 1,
    name: "TustJazzy",
    data: {
      vehicle: "Lamborghini",
      model: "Aventador",
      plate: "ABC123",
      price: "1000000",
      expire: "6 hours",
      boost: {
        type: "S+",
      },
    },
    owner: {
      name: "My boy treyy 😎",
      phone: "123456789",
    },
  },
  {
    id: 2,
    name: "TustJazzy",
    data: {
      vehicle: "Lamborghini",
      model: "Aventador",
      plate: "ABC123",
      price: "1000000",
      expire: "3 hours",
      boost: {
        type: "S+",
      },
    },
    owner: {
      name: "That guy from walmart",
      phone: "123456789",
    },
  },
  {
    id: 3,
    name: "Jayce",

    data: {
      vehicle: "Lamborghini",
      model: "Aventador",
      plate: "ABC123",
      price: "1000000",
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

export const saledcontracts = writable([]);
