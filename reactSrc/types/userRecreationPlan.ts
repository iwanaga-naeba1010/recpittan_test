import { RecreationRecreationPlan } from './recreationRecreationPlan';
import { User } from './user';
import { RecreationPlan } from './recreationPlan';

export interface UserRecreationPlan {
  code: string;
  title: string;
  user: User;
  RecreationPlan: RecreationPlan;
  userRecreationRecreationPlans: Array<RecreationRecreationPlan>;
}
