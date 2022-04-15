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
  instructor_description: string;
  instructor_image: string;
  instructor_name: string;
  instructor_position: string;
  instructor_title: string;
  tags: Tag[];
  targets: Tag[];
}
