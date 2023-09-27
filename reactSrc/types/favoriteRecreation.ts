import { Recreation } from './recreation';

export interface FavoriteRecreation {
  id: number;
  userId: number;
  recreationId: number;
  recreation: Recreation;
  isFavorite: boolean;
}
