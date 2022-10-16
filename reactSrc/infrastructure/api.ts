import { ApiType } from '@/types';
import axios, { AxiosResponse } from 'axios';
import camelcaseKeys from 'camelcase-keys';
import snakecaseKeys from 'snakecase-keys';

export class Api {
  static async get<T>(path: string, type: ApiType, params: Record<string, unknown> = {}): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.get<T>(`${apiDomain(type)}/${path}`, {
        params: snakecaseKeys(params),
        headers: headers()
      });
      return { ...response, data: camelcaseKeys(response.data, { deep: true }) } as AxiosResponse<T>;
    } catch (e) {
      console.log('haitta!', e);
      throw e;
    }
  }

  // TODO(okubo): Promise<any>をaxios returnでgenericsに変更
  static async post<T>(path: string, type: ApiType, data: Record<string, unknown>): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.post<T>(`${apiDomain(type)}/${path}`, snakecaseKeys(data, { deep: true }), {
        headers: headers()
      });
      return { ...response, data: camelcaseKeys(response.data, { deep: true }) } as AxiosResponse<T>;
    } catch (e) {
      console.log('haitta!', e);
      throw e;
    }
  }

  static async patch<T>(path: string, type: ApiType, data: Record<string, unknown>): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.patch(`${apiDomain(type)}/${path}`, snakecaseKeys(data), { headers: headers() });
      return { ...response, data: camelcaseKeys(response.data, { deep: true }) } as AxiosResponse<T>;
    } catch (e) {
      console.log('haitta!', e);
      throw e;
    }
  }

  static async delete<T>(path: string, type: ApiType, data: Record<string, unknown>): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.delete(`${apiDomain(type)}/${path}`, {
        data: snakecaseKeys(data),
        headers: headers()
      });
      return { ...response, data: camelcaseKeys(response.data, { deep: true }) } as AxiosResponse<T>;
    } catch (e) {
      console.log('haitta!', e);
      throw e;
    }
  }
}

// const headers = (token?: string) => {
const headers = () => {
  const headers = {
    'Content-Type': 'application/json'
  };
  const token = document.querySelector('[name=csrf-token]').getAttribute('content');

  return {
    ...headers,
    'X-CSRF-TOKEN': token
    // Authorization: `Bearer ${token}`
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
