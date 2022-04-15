import { Base } from './base';
import { Tag } from './tag';

export interface Recreation extends Base {
  id: number;
  title: string;
  secondTitle: string;
  minutes: number;
  isOnline: boolean;
  capacity: number;
  imageUrl: string;
  category: string;
  categoryId: number;
  instructorDescription: string;
  instructorImage: string;
  instructorName: string;
  instructorPosition: string;
  instructorTitle: string;
  tags: Tag[];
  targets: Tag[];
}
