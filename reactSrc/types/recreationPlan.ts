import { RecreationRecreationPlan } from './recreationRecreationPlan';

export interface RecreationPlan {
  id: number;
  code: string;
  title: string;
  adjustmentFee: number;
  recreationRecreationPlans: Array<RecreationRecreationPlan>;
}
