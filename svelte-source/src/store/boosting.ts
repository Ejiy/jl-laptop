import { fetchNui } from "../utils/eventHandler";
import { writable } from "svelte/store";
import type { IContracts, ISaledContract } from "../@types/boosting";

export const contracts = writable<IContracts[]>([]);
export const startedContracts = writable<IContracts>({
  contract: "A+",
  car: "Audi",
  expire: 1658208866000,
  id: 323,
  owner: "Some guy",
  type: "boosting",
  vinscratch: false,
});

let contractsStore: IContracts[];
let startedContractStore: IContracts;

const unsubsContracts = contracts.subscribe((v) => {
  contractsStore = v;
});

const unsubscribeContractStart = startedContracts.subscribe((v) => {
  startedContractStore = v;
});

setInterval(() => {
  if (contractsStore.length > 0) {
    contractsStore.forEach((x) => {
      if (new Date(x.expire) < new Date()) {
        contracts.set(contractsStore.filter((y) => y.id !== x.id));
        fetchNui("boosting/expire", { id: x.id });
      }
    });
  }
}, 1000);

export function handleContracts(data: IContracts[]) {
  contracts.set(data);
}

export const queue = writable(false);

export const started = writable(false);

export const saledcontracts = writable<ISaledContract[]>([]);
