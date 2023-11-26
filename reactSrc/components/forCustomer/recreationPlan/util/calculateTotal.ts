import { RecreationRecreationPlan } from '@/types';

export const calculateTotal = (
  plans: RecreationRecreationPlan[],
  property: 'price' | 'materialPrice'
): number => {
  return plans.reduce((total, plan) => {
    const amount = plan.recreation[property];
    return typeof amount === 'number' ? total + amount : total;
  }, 0);
};
