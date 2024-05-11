import { RecreationPlan } from './recreationPlan';

export interface recreationPlanEstimate {
  estimate_number: string
  number_of_people: number
  start_month: number
  transportation_expenses: number
  recreationPlan: RecreationPlan
}
