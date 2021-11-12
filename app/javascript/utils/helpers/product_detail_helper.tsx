import { KindEnum } from '../../types/product_detail';

export const adjustIndex = (kind: KindEnum, index: number): number => {
  switch (kind) {
    case 'appeal':
      return index + 3;
    case 'property':
      return index + 6;
    default:
      return index;
  }
}
