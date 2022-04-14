import { Tag } from './tag';

export interface Recreation {
  id: number;
  title: string;
  second_title: string;
  minutes: number;
  is_online: boolean;
  capacity: number;
  image_url: string;
  category: string;
  category_id: number;
  tags: Tag[];
  targets: Tag[];
}
