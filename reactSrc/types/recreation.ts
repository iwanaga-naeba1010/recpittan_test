import { Base } from './base';
import { Tag } from './tag';

export interface Recreation extends Base {
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
  tags: Array<Tag>;
  targets: Array<Tag>;
}
