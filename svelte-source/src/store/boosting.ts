import { writable } from "svelte/store";

interface contracts {
  id: number;
  contract: string;
  car: string;
  expire: number;
  owner: string;
  vinscratch: boolean;
}

const contract: contracts[] = [];
const startedContract: contracts[] = [];

export const contracts = writable(contract);
export const startedContracts = writable(startedContract);

let contractsStore: contracts[];
let startedContractStore: contracts[];

const unsubsContracts = contracts.subscribe((v) => {
  contractsStore = v;
});

const unsubscribeContractStart = startedContracts.subscribe((v) => {
  startedContractStore = v;
});

export function handleContracts(data: contracts[]) {
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
