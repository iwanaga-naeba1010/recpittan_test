import { BaseEnum } from './baseEnum';
import { Report } from './report';

export interface Evaluation extends BaseEnum {
  communication : number;
  ingenuity: number;
  isPublic: boolean;
  message: string;
  otherMessage: string;
  price: BaseEnum;
  smoothness: BaseEnum;
  wantToOrderAgein: BaseEnum;
  report: Report;
}
