import React, { useEffect, useState } from "react";
import { Order, ResponseChat, User } from "@/types";
import { ChatItem } from "./chatItem";
import { ChatForm } from "@/components/shared/form";
import { Api } from "@/infrastructure";

type Props = {
  user: User;
  order: Order;
};

export const ChatList: React.FC<Props> = (props): JSX.Element => {
  const { user, order } = props;
  const [chats, setChats] = useState<ResponseChat>();

  const handleLoadChats = async (): Promise<void> => {
    const response = await Api.get<ResponseChat>(`/orders/${order.id}/chats`, "customer");
    setChats(response.data);
  };

  useEffect(() => {
    if (order === undefined) return;
    (async () => await handleLoadChats())();
  }, [order]);

  return (
    <>
      <div className="col-md-7">
        <div className="card chat-container">
          <div className="card-header bg-white">
            {order?.recreation?.instructorName} さんとのチャット
          </div>
          <div className="card-body bg-ba02">
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
      </div>
    </>
  );
};
