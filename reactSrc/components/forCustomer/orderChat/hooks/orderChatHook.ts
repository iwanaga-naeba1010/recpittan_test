import { Api } from '@/infrastructure';
import { ResponseChat } from '@/types';

type UserOrderChatHook = {
  fetchChats: (orderId: number) => Promise<ResponseChat>;
};

export const useOrderChat = (): UserOrderChatHook => {
  const fetchChats = async (orderId: number): Promise<ResponseChat> => {
    return (await Api.get<ResponseChat>(`/orders/${orderId}/chats`, 'customer'))
      .data;
  };
  return {
    fetchChats,
  };
};
