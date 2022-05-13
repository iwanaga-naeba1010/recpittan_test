import { Base } from './base';

export interface Profile extends Base {
  name: string;
  description: string;
  position: string;
  title: string;
  userId: number;
}

