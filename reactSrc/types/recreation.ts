import { Base } from './base';
import { Tag } from './tag';

type KindEnum = 'visit' | 'online' | 'mailing';

export interface Recreation extends Base {
  title: string;
  secondTitle: string;
  minutes: number;
  price: number;
  description: string;
  kind: KindEnum;
  status: string;
  flowOfDay: string;
  capacity: number;
  materialAmount: number;
  materialPrice: number;
  extraInformation: string;
  youtubeId: string;
  additionalFacilityFee: number;
  borrowItem: string;
  imageUrl: string;
  category: string;
  prefectures: Array<string>;
  categoryId: number;
  profile: Array<string>;
  userId: number;
  tags: Array<Tag>;
  targets: Array<Tag>;
}
