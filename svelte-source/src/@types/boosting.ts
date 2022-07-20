export interface IContracts {
  id: number;
  contract: string;
  carName: string;
  expire: number;
  owner: string;
  vinscratch: boolean;
  type: "boosting" | "vinscratch";
  cost: number;
}

export interface ISaledContract extends IContracts {
  price: number;
}
