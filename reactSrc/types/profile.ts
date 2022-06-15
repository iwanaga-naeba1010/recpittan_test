import { BaseRecord } from './baseRecord';

export interface Profile extends BaseRecord {
  name: string;
  description: string;
  position: string;
  title: string;
  userId: number;
  image?: string;
}
