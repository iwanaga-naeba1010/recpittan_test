import { BaseEnum } from './baseEnum';
import { Report } from './report';
import { EvaluationReply } from './evaluationReply';

export interface Evaluation extends BaseEnum {
  communication: number;
  ingenuity: number;
  isPublic: boolean;
  message: string;
  otherMessage: string;
  price: BaseEnum;
  smoothness: BaseEnum;
  wantToOrderAgein: BaseEnum;
  report: Report;
  evaluationReply?: EvaluationReply;
}
