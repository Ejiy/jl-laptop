import { fetchNui } from "../utils/eventHandler";
import { writable } from "svelte/store";
import type { IContracts, ISaledContract } from "../@types/boosting";

export const contracts = writable<IContracts[]>([
  {
    id: 5,
    contract: "S+",
    carName: "Zentorno",
    expire: 1660578622000,
    cost: 1000,
    owner: "Shitr",
    type: "boosting",
    vinscratch: false,
  },
  {
    id: 7,
    contract: "B",
    carName: "Banshee",
    expire: 1660578622000,
    cost: 1000,
    owner: "Fjamzoo",
    type: "vinscratch",
    vinscratch: true,
  },
  {
    id: 6,
    contract: "A+",
    carName: "Sultan",
    expire: 1660578622000,
    cost: 1000,
    owner: "Not Lazzy",
    type: "vinscratch",
    vinscratch: true,
  },
  {
    id: 9,
    contract: "D",
    carName: "Banshee",
    expire: 1660578622000,
    cost: 1000,
    owner: "Lazzy",
    type: "boosting",
    vinscratch: false,
  },
]);
export const startedContracts = writable<IContracts>(null);

let contractsStore: IContracts[];
let startedContractStore: IContracts;

const unsubsContracts = contracts.subscribe((v) => {
  contractsStore = v;
});

const unsubscribeContractStart = startedContracts.subscribe((v) => {
  startedContractStore = v;
});

// setInterval(() => {
//   if (contractsStore.length > 0) {
//     contractsStore.forEach((x) => {
//       if (new Date(x.expire) < new Date()) {
//         contracts.set(contractsStore.filter((y) => y.id !== x.id));
//         fetchNui("boosting/expire", { id: x.id });
//       }
//     });
//   }
// }, 1000);

export function handleContracts(data: IContracts[]) {
  contracts.set(data);
}

export const queue = writable(false);

export const started = writable(false);

export const saledcontracts = writable<ISaledContract[]>([]);
