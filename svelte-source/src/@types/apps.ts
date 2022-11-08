export interface IApp {
  name: string;
  icon: string;
  hide?: boolean;
  text: string;
  color: string;
  background: string | object;
  isopen: boolean;
  useimage: boolean;
}

export interface IOpenedApp {
  name: string;
  component: any;
  icon: string;
  color: string;
  background: string | object;
  useimage: boolean;
}
