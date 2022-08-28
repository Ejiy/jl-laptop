export interface Items {
  name: string;
  label: string;
  image: string;
  price: number;
  stock: number;
}

export interface BennysItem extends Items {
  category: "Cosmetic Parts" | "Performance Parts" | "Consumable Parts";
}

export interface DarkWebItems extends Items {
  category: "hacking" | "guns" | "drugs";
}

export interface BennysCartItems extends BennysItem {
  quantity: number;
}

export interface DarkWebCartItems extends DarkWebItems {
  quantity: number;
}
