import React from "react";
import { Recreation, User } from "../../types";
import { Chat } from "../../types";
import { prettyHM } from "../../utils";

type FacilityChatProps = {
  chat: Chat;
};

const FacilityChat: React.FC<FacilityChatProps> = (props) => {
  const { chat } = props;
  return (
    <div className="row justify-content-end pt-2">
      <div className="col-auto align-self-end time">
        {prettyHM(chat.createdAt)}
      </div>
      {/* TODO(okubo): linkあればlink化する */}
      <div className="col-md-auto customer-text">
        {chat.message.split("\n").map((char) => (
          <>
            {char}
            <br />
          </>
        ))}
      </div>
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
    <div className="row justify-content-start instructor pt-2">
      <div className="col-auto align-self-start image pe-0">
        <img src="{{catalogThumbnailUri userId '128x128' 'jpg'}}" />
      </div>
      <div className="col-md-auto">
        <div className="name">{recreation.instructorName}</div>
        <div className=" text">
          <a
            href={chat.fileUrl}
            className="text-black"
            target="_blank"
            rel="noopener"
          >
            {chat.filename}
          </a>
        </div>
      </div>
      <div className="col-auto align-self-end time">
        {prettyHM(chat.createdAt)}
      </div>
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
      <div className="row justify-content-start instructor pt-2">
        <div className="col-auto align-self-start image pe-0">
          <img src="{{catalogThumbnailUri userId '128x128' 'jpg'}}" />
        </div>
        <div className="col-md-auto">
          <div className="name">{recreation.instructorName}</div>
          <div className=" text">
            {/* TODO(okubo): linkあればlink化する */}
            {chat.message.split("\n").map((char) => (
              <>
                {char}
                <br />
              </>
            ))}
          </div>
        </div>
        <div className="col-auto align-self-end time">
          {prettyHM(chat.createdAt)}
        </div>
      </div>
      <FileItem chat={chat} recreation={recreation} />
    </>
  );
};

type Props = {
  recreation: Recreation;
  date: string;
  chats: Chat[];
  currentUser: User;
};

export const ChatItem: React.FC<Props> = (props) => {
  const { recreation, chats, date, currentUser } = props;
  console.log({ currentUser, chats });

  return (
    <>
      <div className="row justify-content-center pt-2">
        <div className="col-auto date">{date}</div>
      </div>
      {chats?.map((chat) => (
        <>
          {currentUser.id === chat.userId && (
            <FacilityChat key={chat.id} chat={chat} />
          )}
          {currentUser.id !== chat.userId && (
            <PartnerChat key={chat.id} recreation={recreation} chat={chat} />
          )}
        </>
      ))}
    </>
  );
};
