import { Base } from './base';
import { Recreation } from './recreation';

// export type OrderStatusEnum =
//   | 'inProgress'
//   | 'waitingForAReplyFromPartner'
//   | 'waitingForAReplyFromFacility'
//   | 'facilityRequestInProgress'
//   | 'requestDenied'
//   | 'waitingForAnEventToTakePlace'
//   | 'unreportedCompleted'
//   | 'finalReportAdmitsNot'
//   | 'finished';

export interface Order extends Base {
  zip: string;
  prefecture: string;
  city: string;
  street: string;
  building: string;
  startAt: Date;
  endAt: Date;
  // status: OrderStatusEnum;
  isEditable: boolean;
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
  'id' | 'totalPriceForCustomer' | 'totalFacilityPriceForCustomer' | 'totalMaterialPriceForCustomer' | 'recreation'
>;
