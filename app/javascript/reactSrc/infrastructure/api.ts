// import * as Sentry from '@sentry/react';
import axios, {AxiosResponse} from 'axios';
import { ApiType } from '../types';
import snakecaseKeys from 'snakecase-keys';
import camelcaseKeys from 'camelcase-keys';

export class Api {
  static async get<T>(
    path: string,
    type: ApiType,
    token?: string,
    params: Record<string, unknown> = {},
    isSendErrorMessage = true
  ): Promise<AxiosResponse<T>> {
    try {
      const response = await axios.get<T>(`${apiDomain(type)}/${path}`, {params: snakecaseKeys(params), headers: headers(token)});
      return {...response, data: camelcaseKeys(response.data, {deep: true})} as AxiosResponse<T>;
    } catch (e) {
      if (isSendErrorMessage) {
        // Sentry.captureException(e);
      }
      throw e;
    }
  }

  // TODO(okubo): Promise<any>をaxios returnでgenericsに変更
  static async post<T>(path: string, type: ApiType, data: Record<string, unknown>): Promise<AxiosResponse<T>> {
    try {
      const token = document
        .querySelector("[name=csrf-token]")
        .getAttribute("content");
      const response = await axios.post<T>(`${apiDomain(type)}/${path}`, snakecaseKeys(data), {headers: headers(token)});
      return {...response, data: camelcaseKeys(response.data, {deep: true})} as AxiosResponse<T>;
    } catch (e) {
      // Sentry.captureException(e);
      throw e;
    }
  }

  static async patch<T>(path: string, type: ApiType, data: Record<string, unknown>): Promise<AxiosResponse<T>> {
    try {
      const token = document
        .querySelector("[name=csrf-token]")
        .getAttribute("content");

      const response = await axios.patch(`${apiDomain(type)}/${path}`, snakecaseKeys(data), {headers: headers(token)});
      return {...response, data: camelcaseKeys(response.data, {deep: true})} as AxiosResponse<T>;
    } catch (e) {
      // Sentry.captureException(e);
      throw e;
    }
  }

  static async delete<T>(path: string, type: ApiType, data: Record<string, unknown>): Promise<AxiosResponse<T>> {
    try {
      const token = document
        .querySelector("[name=csrf-token]")
        .getAttribute("content");

      const response = await axios.delete(`${apiDomain(type)}/${path}`, {data: snakecaseKeys(data), headers: headers(token)});
      return {...response, data: camelcaseKeys(response.data, {deep: true})} as AxiosResponse<T>;
    } catch (e) {
      // Sentry.captureException(e);
      throw e;
    }
  }
}

const headers = (token?: string) => {
  const headers = {
    'Content-Type': 'application/json'
  };

  if (!token) return headers;

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

const COMMON_API_DOMAIN: string = (() => {
  return 'http://localhost:3000/api';
  // if (process.env.ENVIRONMENT === 'development' || process.env.STAGING) {
  //   return 'http://localhost:3000/api';
  // } else {
  //   return 'https://recreation.everyplus.jp/api_partner/api';
  // }
})();

const CUSTOMER_API_DOMAIN: string = (() => {
  return 'http://localhost:3000/api_customer';
  // if (process.env.ENVIRONMENT === 'development' || process.env.STAGING) {
  //   return 'http://localhost:3000/api_customer';
  // } else {
  //   return 'https://recreation.everyplus.jp/api_customer';
  // }
})();

const PARTNER_API_DOMAIN: string = (() => {
  return 'http://localhost:3000/api_partner';
  // if (process.env.ENVIRONMENT === 'development' || process.env.STAGING) {
  //   return 'http://localhost:3000/api_partner';
  // } else {
  //   return 'https://recreation.everyplus.jp/api_partner';
  // }
})();


const APP_API_DOMAIN: string = (() => {
  if (process.env.ENVIRONMENT === 'development' || process.env.STAGING) {
    return 'http://localhost:3000';
  } else {
    return 'https://recreation.everyplus.jp';
  }
})();


