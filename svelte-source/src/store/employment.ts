import { writable } from "svelte/store";

export const groupname = writable(null);

interface IStages {
    id: number | string;
    name: string;
    description: string;
    done: boolean
}

export const stages = writable<IStages[]>([])

