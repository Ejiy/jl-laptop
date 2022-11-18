import { writable } from "svelte/store";
import type {
  IContracts,
  ISaledContract,
  IStartedContract,
} from "../@types/boosting";

export const contracts = writable<IContracts[]>([]);
export const startedContracts = writable<IStartedContract>(null);

export function handleContracts(data: IStartedContract[]) {
  contracts.set(data);
}

export const canCancel = writable(false);

export const queue = writable(false);

export const started = writable(false);

export const saledcontracts = writable<ISaledContract[]>([]);
