import { BaseRecord } from './baseRecord';
import { Recreation } from './recreation';
import { User } from './user';

export interface Order extends BaseRecord {
  zip: string;
  prefecture: string;
  city: string;
  street: string;
  building: string;
  startAt: Date;
  endAt: Date;
  isEditable: boolean;
  expenses: number;
  transportationExpenses: number;
  additionalFacilityFee: number;
  numberOfPeople: number;
  numberOfFacilities: number;
  price: number;
  couponCode: string;
  materialPrice: number;
  totalPriceForCustomer: number;
  totalFacilityPriceForCustomer: number;
  totalMaterialPriceForCustomer: number;
  recreation: Recreation;
  user: User;
}

export type OrderRequest = Omit<
  Order,
  'id' | 'totalPriceForCustomer' | 'totalFacilityPriceForCustomer' | 'totalMaterialPriceForCustomer' | 'recreation'
>;
