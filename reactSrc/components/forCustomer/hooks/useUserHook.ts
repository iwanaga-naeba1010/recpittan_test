import { Api } from '@/infrastructure';
import { User } from '@/types';

type UseUserHook = {
  fetchUser: () => Promise<User>;
};

export const useUser = (): UseUserHook => {
  const fetchUser = async (): Promise<User> => {
    return (await Api.get<User>(`/users/self`, 'common')).data;
  };
  return { fetchUser };
};
