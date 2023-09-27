import { Recreation, FavoriteRecreation } from '@/types';
import React from 'react';
import { FavoriteIcon } from './favoriteIcon';

type Props = {
  deleteFavoriteRecreation: (id: number) => Promise<void>;
  fetchFavoriteRecreations: () => Promise<Array<FavoriteRecreation>>;
  setFavoriteRecreations: (favorites: Array<FavoriteRecreation>) => void;
  recreation: Recreation;
  favoriteRecreation: FavoriteRecreation;
};

const getKindLabel = (key: string): string => {
  switch (key) {
    case 'online':
      return 'オンライン';
    case 'visit':
      return '訪問';
    case 'mailing':
      return '郵送';
    default:
      return key;
  }
};

export const RecreationItem: React.FC<Props> = (props) => {
  const { favoriteRecreation, recreation } = props;
  const handleFavoriteRecreationDelete = async (id: number) => {
    if (!confirm('お気に入りから削除しますか？')) return;
    try {
      await props.deleteFavoriteRecreation(id);
      const updatedFavorites = await props.fetchFavoriteRecreations();  // お気に入りを再取得
      props.setFavoriteRecreations(updatedFavorites); // 新しい一覧を状態にセット
    } catch (error) {
      console.error("Error deleting favorite", error);
    }
  };

  return(
    <section className="col-sm-6 col-md-4 col-lg-3 mb-4">
      <div className="card recreation-card h-100 shadow text-decoration-none">
          <a href={`/customers/recreations/${recreation.id}`} className='card-img-top zoom'>
            <picture>
              <img src={`${recreation.images[0].imageUrl}`} alt="" />
              <p className="position-absolute bg-white text-black top-0 end-0 m-2 px-1 border border-dark rounded">{getKindLabel(recreation.kind.key)}</p>
            </picture>
          </a>

          <a href={`/customers/recreations/${recreation.id}`} className='clink'>
            <div className='card-body card-body-main p-2 pb-0'>
              <h1 className="card-title mb-0">
                <p>{recreation.title}</p>
              </h1>
            </div>
          </a>

        <div className="card-body card-body-info px-2 py-1">
          <div className="d-md-flex mb-2 align-items-center">
            <div>
              <i className="material-icons every">query_builder</i>
              <span className="value">{recreation.minutes}</span>
            </div>
            <div className='ms-1'>
              <FavoriteIcon
                onClick={() => handleFavoriteRecreationDelete(favoriteRecreation.id)}
                isFavorited={true}
              />
            </div>

            <div className="ms-md-auto">
              <span className="value">￥{recreation.price}</span>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
};
