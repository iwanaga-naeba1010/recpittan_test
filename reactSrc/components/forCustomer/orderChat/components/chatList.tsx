import { ChatForm } from '@/components/shared/form';
import { Order, ResponseChat, User } from '@/types';
import React, { useEffect, useState } from 'react';
import { ChatItem } from './chatItem';
import { useOrderChat } from '../hooks';

type Props = {
  user: User;
  order: Order;
};

export const ChatList: React.FC<Props> = (props) => {
  const { user, order } = props;
  const [chats, setChats] = useState<ResponseChat>();
  const { fetchChats } = useOrderChat();

  const handleLoadChats = async (): Promise<void> => {
    const chats = await fetchChats(order.id);
    setChats(chats);
  };

  useEffect(() => {
    if (order === undefined) return;
    (async () => await handleLoadChats())();
  }, [order]);

  return (
    <div className='card chat-container'>
      <div className='card-header bg-white'>
        {order?.recreation?.profile?.name} さんとのチャット
      </div>
      <div className='card-body bg-ba02'>
        {chats !== undefined && (
          <>
            {Object?.entries(chats).map(([key, chats]) => (
              <ChatItem
                key={key}
                currentUser={user}
                recreation={order?.recreation}
                date={key}
                chats={chats}
              />
            ))}
          </>
        )}
      </div>
      <ChatForm order={order} loadChats={handleLoadChats} />
    </div>
  );
};
