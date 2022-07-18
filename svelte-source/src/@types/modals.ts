export interface IModals {
  show: boolean;
  title: string;
  input?: boolean;
  inputType?: "text" | "number" | "password";
  inputValue?: string;
  inputPlaceholder?: string;
  onOk: (value?: string) => void;
  onCancel: (value?: string) => void;
  okText?: string;
  cancelText?: string;
  description?: string;
}
