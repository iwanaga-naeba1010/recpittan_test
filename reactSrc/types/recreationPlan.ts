import { Recreation } from './recreation';

export interface RecreationPlan {
  code: string;
  title: string;
  recreations: Array<Recreation>;
}
