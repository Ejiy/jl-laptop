export interface IApp {
  name: string;
  icon: string;
  hide?: boolean;
  text: string;
  color: string;
  background: string;
  isopen: boolean;
  useimage: boolean;
}

export interface IOpenedApp {
  name: string;
  component: any;
  icon: string;
  color: string;
  background: string;
  useimage: boolean;
}
