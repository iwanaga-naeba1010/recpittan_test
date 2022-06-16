import { BaseEnum } from './baseEnum';
import { Profile } from './profile';
import { Tag } from './tag';

export interface Recreation extends BaseEnum {
  title: string;
  secondTitle: string;
  minutes: number;
  price: number;
  description: string;
  kind: BaseEnum;
  status: BaseEnum;
  category: BaseEnum;
  flowOfDay: string;
  capacity: number;
  materialAmount: number;
  materialPrice: number;
  extraInformation: string;
  youtubeId: string;
  additionalFacilityFee: number;
  borrowItem: string;
  imageUrl: string;
  prefectures: Array<string>;
  profile: Profile;
  userId: number;
  tags: Array<Tag>;
  targets: Array<Tag>;
}
