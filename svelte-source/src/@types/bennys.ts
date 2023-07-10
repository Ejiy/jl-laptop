export type Items = {
  name: string;
  label: string;
  image: string;
  price: number;
  stock: number;
};

export type Categories = {
  name: string;
  label: string;
  default?: boolean;
};

export type BennysItem = Items & {
  category: string;
};

export type DarkWebItems = Items & {
  category: "hacking" | "guns" | "drugs";
};

export type BennysCartItems = BennysItem & {
  quantity: number;
};

export type DarkWebCartItems = DarkWebItems & {
  quantity: number;
};
