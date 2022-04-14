import React, { Dispatch, useEffect, useState } from "react";
import { Order } from "../../types";
import { useForm } from 'react-hook-form';
import { get, put } from "../../../utils/requests/base";
import {Chat} from "../../types";

type Props = {
  orderId: number;
}

type ChatFormValues = Pick<Order, 'number_of_facilities'>;

export const ChatList: React.FC<Props> = (props): JSX.Element => {
  const {orderId} = props;

  useEffect(() => {
    if (orderId === undefined) return;
    (async() => {
      const response = await get<Chat>(`/api/orders/${orderId}/chats`);
      console.log({ response });
    })()
  }, [orderId]);

  return (
    <>
    </>
  )
}

