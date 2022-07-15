export interface Items {
  name: string;
  label: string;
  image: string;
  price: number;
  stock: number;
  category: string;
}

// extends Items interface
export interface CartItems extends Items {
  quantity: number;
}
