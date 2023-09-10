import { Api } from '@/infrastructure';
import { ResponseChat } from '@/types';

type UseOrderChatHook = {
  fetchChats: (orderId: number) => Promise<ResponseChat>;
};

export const useOrderChat = (): UseOrderChatHook => {
  const fetchChats = async (orderId: number): Promise<ResponseChat> => {
    return (await Api.get<ResponseChat>(`/orders/${orderId}/chats`, 'customer'))
      .data;
  };
  return {
    fetchChats,
  };
};
