import type { IModals } from "../@types/modals";
import { writable } from "svelte/store";

function ModalFunction() {
  const _modals = writable<IModals>(null);
  function show(data: IModals): void {
    _modals.set(data);
  }

  function reset(): void {
    _modals.set(null);
  }

  const { subscribe, set } = _modals;

  return {
    subscribe,
    set,
    show,
    reset,
  };
}

export const modals = ModalFunction();
