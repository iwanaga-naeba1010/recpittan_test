import { Api } from '@/infrastructure';
import { Order } from '@/types';

type UseOrderHook = {
  fetchOrder: (orderId: number) => Promise<Order>;
};

export const useOrder = (): UseOrderHook => {
  const fetchOrder = async (id: number): Promise<Order> => {
    return (await Api.get<Order>(`/orders/${id}`, 'customer')).data;
  };
  return { fetchOrder };
};
