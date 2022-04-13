import { Recreation } from "./recreation";

export interface Order {
  id: number;
  expenses: number;
  transportation_expenses: number;
  additional_facility_fee: number;
  number_of_people: number;
  number_of_facilities: number;
  price: number;
  material_price: number;
  total_price_for_customer: number;
  total_facility_price_for_customer: number;
  total_material_price_for_customer: number;
  recreation: Recreation;
}
