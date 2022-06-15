import { BaseRecord } from './baseRecord';

export interface Chat extends BaseRecord {
  orderId: number;
  userId: number;
  message: string;
  fileUrl: string;
  filename: string;
}

export interface ResponseChat {
  [key: string]: Array<Chat>;
}
