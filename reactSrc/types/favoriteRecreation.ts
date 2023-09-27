import { Recreation } from './recreation';

export interface FavoriteRecreation {
  id: number;
  user_id: number;
  recreation_id: number;
  recreation: Recreation;
  isFavorite: boolean;
}
