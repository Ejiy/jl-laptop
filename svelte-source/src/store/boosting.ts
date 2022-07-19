import { writable } from "svelte/store";
import type { IContracts, ISaledContract } from "../@types/boosting";

export const contracts = writable<IContracts[]>([
  // {
  //   owner: "Not Lazzy",
  //   type: "boosting",
  //   car: "Audi A6",
  //   contract: "D",
  //   expire: 1658284363000,
  //   id: 32,
  //   vinscratch: false,
  // },
  // {
  //   owner: "Not Lazzy",
  //   type: "vinscratch",
  //   car: "Audi A6",
  //   contract: "C",
  //   expire: 1658208866,
  //   id: 33,
  //   vinscratch: false,
  // },
  // {
  //   owner: "Not Lazzy",
  //   type: "boosting",
  //   car: "Audi A6",
  //   contract: "B",
  //   expire: 1658284363000,
  //   id: 34,
  //   vinscratch: false,
  // },
  // {
  //   owner: "Not Lazzy",
  //   type: "vinscratch",
  //   car: "Audi A6",
  //   contract: "S",
  //   expire: 1658284363000,
  //   id: 35,
  //   vinscratch: false,
  // },
  // {
  //   owner: "Not Lazzy",
  //   type: "boosting",
  //   car: "Audi A6",
  //   contract: "S+",
  //   expire: 1658284363000,
  //   id: 36,
  //   vinscratch: false,
  // },
]);
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

export const saledcontracts = writable<ISaledContract[]>([]);
