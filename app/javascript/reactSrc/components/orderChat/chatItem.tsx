import React, { Dispatch, useEffect, useState } from "react";
import { Order, Recreation, ResponseChat, User } from "../../types";
import { useForm } from 'react-hook-form';
import { get, put } from "../../../utils/requests/base";
import {Chat} from "../../types";



type FacilityChatProps = {
  chat: Chat;
}

const FacilityChat: React.FC<FacilityChatProps> = (props) => {
  const {chat} = props;
  return (
    <div className="row justify-content-end pt-2">
      <div className="col-auto align-self-end time">{chat.created_at}</div>
      <div className="col-md-auto customer-text">
        {/* TODO(okubo): linkあればlink化する */}
        <div dangerouslySetInnerHTML={{__html: chat.message}} />;
      </div>
    </div>
  )
}


type FileProps = {
  chat: Chat;
  recreation: Recreation;
}

const FileItem: React.FC<FileProps> = (props) => {
  const {chat, recreation} = props;
  return (
    <div className="row justify-content-start instructor pt-2">
      <div className="col-auto align-self-start image pe-0">
        <img src="{{catalogThumbnailUri userId '128x128' 'jpg'}}" />
      </div>
      <div className="col-md-auto">
        <div className="name">{recreation.instructor_name}</div>
        <div className=" text">
          <a href={chat.file_url} className='text-black' target="_blank" rel='noopener'>
            {chat.filename}
          </a>
        </div>
      </div>
      <div className="col-auto align-self-end time">{chat.created_at}</div>
    </div>
  )
}

type PartnerChatProps = {
  recreation: Recreation;
  chat: Chat;
}
const PartnerChat: React.FC<PartnerChatProps> = (props) => {
  const {recreation, chat} = props;
  return (
    <>
      <div className="row justify-content-start instructor pt-2">
        <div className="col-auto align-self-start image pe-0">
          <img src="{{catalogThumbnailUri userId '128x128' 'jpg'}}" />
        </div>
        <div className="col-md-auto">
          <div className="name">{recreation.instructor_name}</div>
          <div className=" text">
            {/* TODO(okubo): linkあればlink化する */}
            <div dangerouslySetInnerHTML={{__html: chat.message}} />;
          </div>
        </div>
        <div className="col-auto align-self-end time">{chat.created_at}</div>
      </div>
      <FileItem chat={chat} recreation={recreation} />
    </>
  )
}


type Props = {
  recreation: Recreation;
  date: string;
  chats: Chat[];
  currentUser: User;
}

export const ChatItem: React.FC<Props> = (props): JSX.Element => {
  const { recreation, chats, date, currentUser } = props;

  return (
    <>
      <div className="row justify-content-center pt-2">
        <div className="col-auto date">{date}</div>
      </div>
      {chats?.map((chat) => (
        <>
          {currentUser.id === chat.user_id && <FacilityChat chat={chat} />}
          {currentUser.id !== chat.user_id && <PartnerChat recreation={recreation} chat={chat} />}
        </>
      ))}
    </>
  )
}

