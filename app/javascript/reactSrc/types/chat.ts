import { Base } from './base';

export interface Chat extends Base {
  id: number;
  order_id: number;
  user_id: number;
  message: string;
  file_url: string;
  filename: string;
}

export interface ResponseChat {
  [key: string]: Chat[];
}
