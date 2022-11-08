import { handleContracts, startedContracts } from "@store/boosting";
import { setApp } from "@store/desktop";
import type { IApp } from "src/@types/apps";
import type { IContracts } from "src/@types/boosting";
import { isEnvBrowser } from "./misc";

export function InitDumyAppData() {
  if (!isEnvBrowser) return;
  let data: Array<IApp> = [
    {
      name: "darkweb",
      icon: "skull",
      text: "Dark Web",
      color: "#fff",
      background: "black",
      isopen: false,
      useimage: false,
    },
    {
      name: "boosting",
      icon: "fa-solid fa-bolt",
      text: "Boosting",
      color: "#fff",
      background: "#1d2029",
      isopen: false,
      useimage: true,
    },
    {
      name: "bennys",
      icon: "fa-solid fa-shopping-cart",
      text: "Bennys Shop",
      color: "#fff",
      background: "#352968",
      isopen: false,
      useimage: false,
    },

    {
      name: "boss",
      icon: "fa-solid fa-circle-user",
      text: "Management",
      color: "#fff",
      background: "#4B5D67",
      isopen: false,
      useimage: false,
    },
    {
      name: "setting",
      icon: "settings",
      text: "Setting",
      color: "#fff",
      background: "#4B5D67",
      isopen: false,
      useimage: false,
    },
    {
      name: "employment",
      icon: "fas fa-users",
      text: "Employment",
      color: "#fff",
      background: "#c26262",
      isopen: false,
      useimage: false
    }
  ];
  setApp(data);
}

export function DumyBoostingData() {
  if (!isEnvBrowser) return;
  let data: IContracts[] = [
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
  ];
  handleContracts(data);
  // startedContracts.set({
  //   id: 9,
  //   contract: "D",
  //   carName: "Banshee",
  //   expire: 1660578622000,
  //   cost: 1000,
  //   owner: "Lazzy",
  //   type: "boosting",
  //   vinscratch: false,
  // });
}
