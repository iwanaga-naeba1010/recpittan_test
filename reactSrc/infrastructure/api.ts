import { ApiType } from '@/types';
import axios, { AxiosResponse } from 'axios';
import camelcaseKeys from 'camelcase-keys';
import snakecaseKeys from 'snakecase-keys';

type Data = Record<string, unknown>;

export class Api {
  static async get<T>(
    path: string,
    type: ApiType,
    params: Data = {},
    responseType: 'json' | 'blob' = 'json'
  ): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.get<T>(`${apiDomain(type)}/${path}`, {
        params: snakecaseKeys(params),
        headers: headers(),
        responseType,
      });

      if (responseType === 'json') {
        const data = response.data as unknown as Record<string, unknown>;
        return {
          ...response,
          data: camelcaseKeys(data, { deep: true }) as T,
        };
      }

      return response;
    } catch (e) {
      console.log('haitta!', e);
      throw e;
    }
  }

  // TODO(okubo): Promise<any>をaxios returnでgenericsに変更
  static async post<T>(
    path: string,
    type: ApiType,
    data: Data = {}
  ): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.post<Data>(
        `${apiDomain(type)}/${path}`,
        snakecaseKeys(data, { deep: true }),
        {
          headers: headers(),
        }
      );
      return {
        ...response,
        data: camelcaseKeys(response.data, { deep: true }) as T,
      };
    } catch (e) {
      console.log('haitta!', e);
      throw e;
    }
  }

  static async patch<T>(
    path: string,
    type: ApiType,
    data: Data = {}
  ): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.patch(
        `${apiDomain(type)}/${path}`,
        snakecaseKeys(data),
        { headers: headers() }
      );
      return {
        ...response,
        data: camelcaseKeys(response.data, { deep: true }) as T,
      };
    } catch (e) {
      console.log('haitta!', e);
      throw e;
    }
  }

  static async delete<T>(
    path: string,
    type: ApiType,
    data: Data = {}
  ): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.delete<Data>(`${apiDomain(type)}/${path}`, {
        data: snakecaseKeys(data),
        headers: headers(),
      });
      return {
        ...response,
        data: camelcaseKeys(response.data, { deep: true }) as T,
      };
    } catch (e) {
      console.log('haitta!', e);
      throw e;
    }
  }
}

const headers = () => {
  let token = '';
  const csrfTokenElem = document.querySelector('[name=csrf-token]');

  if (csrfTokenElem) {
    token = csrfTokenElem.getAttribute('content') ?? '';
  }

  return {
    'Content-Type': 'application/json',
    'X-CSRF-TOKEN': token,
  };
};

const apiDomain = (apiType: ApiType): string => {
  switch (apiType) {
    case 'common':
      return COMMON_API_DOMAIN;
    case 'customer':
      return CUSTOMER_API_DOMAIN;
    case 'partner':
      return PARTNER_API_DOMAIN;
    default:
      return '';
  }
};

// NOTE(okubo): process.env.RAILS_ENVで分けてたけど、不要なので一旦変更で
const COMMON_API_DOMAIN: string = (() => {
  return `${window.location.origin}/api`;
})();

// NOTE(okubo): process.env.RAILS_ENVで分けてたけど、不要なので一旦変更で
const CUSTOMER_API_DOMAIN: string = (() => {
  return `${window.location.origin}/api_customer`;
})();

const PARTNER_API_DOMAIN: string = (() => {
  return `${window.location.origin}/api_partner`;
})();
