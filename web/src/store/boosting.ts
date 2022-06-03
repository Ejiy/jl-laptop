import { writable } from "svelte/store";

interface contracts {
  id: number;
  contractc: string;
  car: string;
  expire: number;
  owner: string;
  vinscratch: boolean;
}

const contract: contracts[] = [];

export const contracts = writable(contract);

let contractsStore: any;

const contractSubscribe = contracts.subscribe((v) => {
  contractsStore = v;
});
export function handleContracts(data: string[]) {
  contracts.set([data[0], ...contractsStore]);
}

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
