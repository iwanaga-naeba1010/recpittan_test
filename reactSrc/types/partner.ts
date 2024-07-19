export interface Partner {
  id: number;
  email: string;
  userName: string;
  userNameKana: string;
  phoneNumber: string;
  postalCode: string;
  prefecture: string;
  city: string;
  address1: string;
  address2?: string; // optional
}
