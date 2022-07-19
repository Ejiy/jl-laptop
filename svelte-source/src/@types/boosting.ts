export interface IContracts {
  id: number;
  contract: string;
  car: string;
  expire: number;
  owner: string;
  vinscratch: boolean;
  type: "boosting" | "vinscratch";
}

export interface ISaledContract extends IContracts {
  price: number;
}
