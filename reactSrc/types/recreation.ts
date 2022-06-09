import { Base } from './base';
import { Tag } from './tag';

//TODO: 多言語対応したい
export type KindEnum = '訪問' | 'オンライン' | '郵送';

export interface Recreation extends Base {
  title: string;
  secondTitle: string;
  minutes: number;
  price: number;
  description: string;
  kind: KindEnum;
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
