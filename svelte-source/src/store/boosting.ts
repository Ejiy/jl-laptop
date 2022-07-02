import { writable } from "svelte/store";
import type { IContracts } from "../@types/boosting";

export const contracts = writable<IContracts[]>([]);
export const startedContracts = writable<IContracts[]>([]);

let contractsStore: IContracts[];
let startedContractStore: IContracts[];

const unsubsContracts = contracts.subscribe((v) => {
  contractsStore = v;
});

const unsubscribeContractStart = startedContracts.subscribe((v) => {
  startedContractStore = v;
});

export function handleContracts(data: IContracts[]) {
  contracts.set(data);
}

export function startContract(id: number) {
  startedContracts.set(contractsStore.filter((v) => v.id === id));
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
