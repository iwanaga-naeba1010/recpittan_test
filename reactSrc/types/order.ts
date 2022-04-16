import { Base } from "./base";
import { Recreation } from "./recreation";

export interface Order extends Base {
  zip: string;
  prefecture: string;
  city: string;
  street: string;
  building: string;
  startAt: Date;
  status: number;
  expenses: number;
  transportationExpenses: number;
  additionalFacilityFee: number;
  numberOfPeople: number;
  numberOfFacilities: number;
  price: number;
  materialPrice: number;
  totalPriceForCustomer: number;
  totalFacilityPriceForCustomer: number;
  totalMaterialPriceForCustomer: number;
  recreation: Recreation;
}

export type OrderRequest = Omit<
  Order,
  | "id"
  | "totalPriceForCustomer"
  | "totalFacilityPriceForCustomer"
  | "totalMaterialPriceForCustomer"
  | "recreation"
>;
