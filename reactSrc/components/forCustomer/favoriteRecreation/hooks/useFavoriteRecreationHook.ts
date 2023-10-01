import { Api } from '@/infrastructure';
import { FavoriteRecreation } from '@/types';
import { useCallback } from 'react';

type UseFavoriteRecreationsHook = {
  fetchFavoriteRecreations: () => Promise<Array<FavoriteRecreation>>;
  fetchFavoriteRecreation: (
    favoriteRecreationId: number
  ) => Promise<FavoriteRecreation>;
  createFavoriteRecreation: (
    recreationId: number
  ) => Promise<FavoriteRecreation>;
  deleteFavoriteRecreation: (favoriteRecreationId: number) => Promise<void>;
};

export const useFavoriteRecreations = (): UseFavoriteRecreationsHook => {
  const fetchFavoriteRecreations = useCallback(async (): Promise<
    Array<FavoriteRecreation>
  > => {
    const response = await Api.get<Array<FavoriteRecreation>>(
      `/favorite_recreations`,
      'customer'
    );
    return response.data;
  }, []);
  const fetchFavoriteRecreation = useCallback(
    async (favoriteRecreationId: number): Promise<FavoriteRecreation> => {
      const response = await Api.get<FavoriteRecreation>(
        `/favorite_recreations/${favoriteRecreationId}`,
        'customer'
      );
      return response.data;
    },
    []
  );
  const createFavoriteRecreation = async (
    recreationId: number
  ): Promise<FavoriteRecreation> => {
    const data = {
      favorite_recreation: {
        recreation_id: recreationId,
      },
    };

    const response = await Api.post<FavoriteRecreation>(
      `/favorite_recreations`,
      'customer',
      data
    );
    return response.data;
  };
  const deleteFavoriteRecreation = async (
    favoriteRecreationId: number
  ): Promise<void> => {
    await Api.delete(
      `/favorite_recreations/${favoriteRecreationId}`,
      'customer'
    );
  };

  return {
    fetchFavoriteRecreations,
    fetchFavoriteRecreation,
    createFavoriteRecreation,
    deleteFavoriteRecreation,
  };
};
