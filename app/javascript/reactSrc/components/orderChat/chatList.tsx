import React, { useEffect, useState } from "react";
import { Order, ResponseChat, User } from "../../types";
import { get, put } from "../../../utils/requests/base";
import { ChatItem } from "./chatItem";
import camelcaseKeys from "camelcase-keys";
import { ChatForm } from "../shared/form";

type Props = {
  user: User;
  order: Order;
};

export const ChatList: React.FC<Props> = (props): JSX.Element => {
  const { user, order } = props;
  const [chats, setChats] = useState<ResponseChat>();

  const handleLoadChats = async (): Promise<void> => {
    const response = await get<ResponseChat>(`/api/orders/${order.id}/chats`);
    setChats(camelcaseKeys(response, { deep: true }));
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
