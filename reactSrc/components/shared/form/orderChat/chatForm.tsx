import React from "react";
import { Chat, Order } from "@/types";
import { useForm } from "react-hook-form";
import { Api } from "@/infrastructure";

type Props = {
  order: Order;
  loadChats: () => Promise<void>;
};

export type ChatFormValues = Pick<Chat, "message">;

export const ChatForm: React.FC<Props> = (props): JSX.Element => {
  const { order, loadChats } = props;
  const { register, handleSubmit, setValue } = useForm<ChatFormValues>({ mode: "onChange" });

  const onSubmit = async (values: ChatFormValues): Promise<void> => {
    const requestBody: {[key: string]: ChatFormValues} = {
      chat: {
        message: values.message,
      },
    };

    try {
      await Api.post(`/orders/${order.id}/chats`, "common", requestBody);
      await loadChats();
      setValue("message", "");
    } catch (e) {}
  };

  return (
    <div className="card-footer bg-white">
      <form className="chat" onSubmit={handleSubmit(onSubmit)}>
        <div className="row align-items-center">
          <div className="col-10 pe-0">
            <textarea
              {...register("message")}
              className="form-control chat-message"
            />
          </div>
          <div className="col-2 text-center px-1">
            <button type="submit" className="btn btn-send">
              送信
            </button>
          </div>
        </div>
      </form>
    </div>
  );
};
