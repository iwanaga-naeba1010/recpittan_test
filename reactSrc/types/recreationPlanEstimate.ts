import { RecreationPlan } from './recreationPlan';

export interface recreationPlanEstimate {
  estimate_number: string;
  numberOfPeople: number;
  startMonth: number;
  transportationExpenses: number;
  recreationPlan: RecreationPlan;
}
