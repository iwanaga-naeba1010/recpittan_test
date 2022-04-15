import React, { Dispatch, useEffect, useState } from "react";
import { Chat, Order, ResponseChat } from "../../types";
import { useForm } from 'react-hook-form';
import { post } from "../../../utils/requests/base";

type Props = {
  order: Order;
  loadChats: () => Promise<void>
}

export type ChatFormValues = Pick<Chat, 'message'>;

export const ChatForm: React.FC<Props> = (props): JSX.Element => {
  const { order, loadChats } = props;
  const [canEdit, setCanEdit] = useState<boolean>(false);

  const {
    register,
    handleSubmit,
    setValue,
  } = useForm<ChatFormValues>({ mode: 'onChange' });

  const onSubmit = async (values: ChatFormValues): Promise<void> => {
    const requestBody: Record<string, unknown> = {
      chat: {
        message: values.message,
      }
    };

    try {
      const token = document.querySelector('[name=csrf-token]').getAttribute('content');
      await post<Chat>( `/api/orders/${order.id}/chats`, requestBody, { 'X-CSRF-TOKEN': token });
      await loadChats();
      setCanEdit(false);
    } catch (e) {
      setCanEdit(true);
    }
  };

  return (
    <div className="card-footer bg-white">
      <form className="chat" onSubmit={handleSubmit(onSubmit)}>
        <div className="row align-items-center">
          <div className="col-10 pe-0">
            <input {...register('message')} className='form-control chat-message' />
          </div>
          <div className="col-2 text-center px-1">
            <button type='submit' className="btn btn-send">
              送信
            </button>
          </div>
        </div>
      </form>
    </div>
  );
}

