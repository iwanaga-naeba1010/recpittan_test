import { Base } from './base';

export interface Chat extends Base {
  id: number;
  orderId: number;
  userId: number;
  message: string;
  fileUrl: string;
  filename: string;
}

export interface ResponseChat {
  [key: string]: Chat[];
}
