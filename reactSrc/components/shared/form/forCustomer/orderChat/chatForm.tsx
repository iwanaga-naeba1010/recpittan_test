import { Error } from '@/components/shared/parts';
import { Api } from '@/infrastructure';
import { Chat, Order } from '@/types';
import { isEmpty } from '@/utils';
import axios, { AxiosError } from 'axios';
import React, { useState } from 'react';
import { useForm } from 'react-hook-form';

type Props = {
  order: Order;
  loadChats: () => Promise<void>;
};

export type ChatFormValues = Pick<Chat, 'message'>;

export const ChatForm: React.FC<Props> = (props): JSX.Element => {
  const { order, loadChats } = props;
  const { register, handleSubmit, setValue } = useForm<ChatFormValues>({ mode: 'onChange' });
  const [errors, setErrors] = useState<Array<string>>([]);

  const onSubmit = async (values: ChatFormValues): Promise<void> => {
    setErrors([]);
    const requestBody: { [key: string]: ChatFormValues } = {
      chat: {
        message: values.message
      }
    };

    try {
      await Api.post(`/orders/${order.id}/chats`, 'customer', requestBody);
      await loadChats();
      setValue('message', '');
    } catch (e) {
      if (axios.isAxiosError(e)) {
        const axiosError = e as AxiosError<Array<string>>;
        if (axiosError.response) {
          setErrors(axiosError.response.data);
          console.log(axiosError.response.data);
        }
      }
    }
  };

  return (
    <div className='card-footer bg-white'>
      {!isEmpty(errors) && <Error errors={errors} />}
      <form className='chat' onSubmit={handleSubmit(onSubmit)}>
        <div className='row align-items-center'>
          <div className='col-10 pe-0'>
            <textarea id='chatInput' {...register('message')} className='form-control chat-message' />
          </div>
          <div className='col-2 text-center px-1'>
            <button id='chatSubmit' type='submit' className='btn btn-send'>
              送信
            </button>
          </div>
        </div>
      </form>
    </div>
  );
};
