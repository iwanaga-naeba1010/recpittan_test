import { Chat, Recreation, User } from '@/types';
import { prettyHM } from '@/utils';
import React from 'react';

type FacilityChatProps = {
  chat: Chat;
};

const replaceNewLineWithBr = (text: string): Array<JSX.Element> =>
  text.split('\n').map((line, i) => (
    <div key={i}>
      {line}
      <br />
    </div>
  ));

const FacilityChat: React.FC<FacilityChatProps> = (props) => {
  const { chat } = props;
  return (
    <div className='row justify-content-end pt-2'>
      <div className='col-auto align-self-end time'>{prettyHM(chat.createdAt)}</div>
      {/* TODO(okubo): linkあればlink化する */}
      <div className='col-md-auto customer-text'>{replaceNewLineWithBr(chat.message)}</div>
    </div>
  );
};

type FileProps = {
  chat: Chat;
  recreation: Recreation;
};

const FileItem: React.FC<FileProps> = (props) => {
  const { chat, recreation } = props;
  return (
    <div className='row justify-content-start instructor pt-2'>
      <div className='col-auto align-self-start image pe-0'>
        <img src={recreation.profile?.image} />
      </div>
      <div className='col-md-auto'>
        <div className='name'>{recreation.profile?.name}</div>
        <div className=' text'>
          <a href={chat.fileUrl} className='text-black' target='_blank' rel='noopener noreferrer'>
            {chat.filename}
          </a>
        </div>
      </div>
      <div className='col-auto align-self-end time'>{prettyHM(chat.createdAt)}</div>
    </div>
  );
};

type PartnerChatProps = {
  recreation: Recreation;
  chat: Chat;
};
const PartnerChat: React.FC<PartnerChatProps> = (props) => {
  const { recreation, chat } = props;
  return (
    <>
      <div className='row justify-content-start instructor pt-2'>
        <div className='col-auto align-self-start image pe-0'>
          <img src={recreation.profile?.image} />
        </div>
        <div className='col-md-auto'>
          <div className='name'>{recreation.profile?.name}</div>
          <div className=' text'>
            {/* TODO(okubo): linkあればlink化する */}
            {replaceNewLineWithBr(chat.message)}
          </div>
        </div>
        <div className='col-auto align-self-end time'>{prettyHM(chat.createdAt)}</div>
      </div>
      {chat.fileUrl !== null && <FileItem key={chat.id} chat={chat} recreation={recreation} />}
    </>
  );
};

type Props = {
  recreation: Recreation;
  date: string;
  chats: Array<Chat>;
  currentUser: User;
};

export const ChatItem: React.FC<Props> = (props) => {
  const { recreation, chats, date, currentUser } = props;

  return (
    <>
      <div className='row justify-content-center pt-2'>
        <div className='col-auto date'>{date}</div>
      </div>
      {chats?.map((chat, i) => (
        <div key={i}>
          {currentUser.id === chat.userId && <FacilityChat chat={chat} />}
          {currentUser.id !== chat.userId && <PartnerChat recreation={recreation} chat={chat} />}
        </div>
      ))}
    </>
  );
};
