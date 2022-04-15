// import * as Sentry from '@sentry/react';
import axios from 'axios';
import { ApiType } from '../types';
import snakecaseKeys from 'snakecase-keys';
import camelcaseKeys from 'camelcase-keys';

export class Api {
  static async get(
    path: string,
    type: ApiType,
    token?: string,
    params: Record<string, unknown> = {},
    isSendErrorMessage = true
  ): Promise<any> {
    try {
      return camelcaseKeys(await axios.get(`${apiDomain(type)}/${path}`, { params: snakecaseKeys(params), headers: headers(token) }), { deep: true })
    } catch (e) {
      if (isSendErrorMessage) {
        // Sentry.captureException(e);
      }
      throw e;
    }
  }

  static async post(path: string, type: ApiType, data: Record<string, unknown>): Promise<any> {
    try {
      const token = document
        .querySelector("[name=csrf-token]")
        .getAttribute("content");

      return camelcaseKeys(await axios.post(`${apiDomain(type)}/${path}`, snakecaseKeys(data), { headers: headers(token) }), { deep: true });
    } catch (e) {
      // Sentry.captureException(e);
      throw e;
    }
  }

  static async patch(path: string, type: ApiType, data: Record<string, unknown>): Promise<any> {
    try {
      const token = document
        .querySelector("[name=csrf-token]")
        .getAttribute("content");

      return camelcaseKeys(await axios.patch(`${apiDomain(type)}/${path}`, snakecaseKeys(data), { headers: headers(token) }), { deep: true });
    } catch (e) {
      // Sentry.captureException(e);
      throw e;
    }
  }

  static async delete(path: string, type: ApiType, data: Record<string, unknown>): Promise<any> {
    try {
      const token = document
        .querySelector("[name=csrf-token]")
        .getAttribute("content");

      return camelcaseKeys(await axios.delete(`${apiDomain(type)}/${path}`, { data: snakecaseKeys(data), headers: headers(token) }), { deep: true });
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


