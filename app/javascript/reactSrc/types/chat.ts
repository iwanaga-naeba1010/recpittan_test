import { Base } from './base';

export interface Chat extends Base {
  orderId: number;
  userId: number;
  message: string;
  fileUrl: string;
  filename: string;
}

export interface ResponseChat {
  [key: string]: Array<Chat>;
}
