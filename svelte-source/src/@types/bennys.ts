export interface Items {
  name: string;
  label: string;
  image: string;
  price: number;
  stock: number;
  category: "Cosmetic Parts" | "Performance Parts" | "Consumable Parts";
}

export interface CartItems extends Items {
  quantity: number;
}
