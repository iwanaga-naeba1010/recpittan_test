import { RecreationPlan } from './recreationPlan';

export interface recreationPlanEstimate {
  estimateNumber: string;
  numberOfPeople: number;
  startMonth: number;
  transportationExpenses: number;
  recreationPlan: RecreationPlan;
}
