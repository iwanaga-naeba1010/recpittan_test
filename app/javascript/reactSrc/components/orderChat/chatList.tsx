import React, { Dispatch, useEffect, useState } from "react";
import { Order, ResponseChat, User } from "../../types";
import { useForm } from 'react-hook-form';
import { get, put } from "../../../utils/requests/base";
import {Chat} from "../../types";
import {ChatItem} from "./chatItem";

type Props = {
  user: User;
  order: Order;
}

type ChatFormValues = Pick<Order, 'number_of_facilities'>;

export const ChatList: React.FC<Props> = (props): JSX.Element => {
  const { user, order } = props;
  const [chats, setChats] = useState<ResponseChat>();

  useEffect(() => {
    if (order === undefined) return;
    (async() => {
      console.log('hogehoge');
      const response = await get<ResponseChat>(`/api/orders/${order.id}/chats`);
      console.log('hogehoge22');
      setChats(response);
      console.log({ response });
    })()
  }, [order]);
  console.log('res is ', chats);

  return (
    <>
      <div className="col-md-7">
        <div className="card chat-container">
          <div className="card-header bg-white">
            {order?.recreation?.instructor_name} さんとのチャット
          </div>
          <div className="card-body bg-ba02">
            {chats !== undefined &&
              <>
                {Object?.entries(chats).map(([key, chats]) =>
                  <ChatItem currentUser={user} recreation={order?.recreation} date={key} chats={chats}  />)
                }
              </>
            }
            {/* {chats?.map((chat) => <ChatItem currentUser={user} recreation={order?.recreation} responseChat={chat}  />)} */}
          </div>
        </div>
      </div>
    </>
  )
}

