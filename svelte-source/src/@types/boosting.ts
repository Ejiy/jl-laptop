export interface IContracts {
  // ID of the contract
  id: number;
  // Car Name
  contract: string;
  carName: string;
  expire: number;
  owner: string;
  vinscratch: boolean;
  type: "boosting" | "vinscratch";
  cost: number;
}

export interface IStartedContract extends IContracts {
  plate?: string;
}

export interface ISaledContract extends IContracts {
  price: number;
}
