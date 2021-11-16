import axios, { AxiosResponse } from 'axios';

const instance = (headers= {}) => {
  return axios.create({
    timeout: 15000,
    headers: {
      ...headers,
      'Content-Type': 'application/json',
    },
  });
}

// const instance = axios.create({
//   timeout: 15000,
//   headers: { 'Content-Type': 'application/json' },
// });

const responseBody = <T = unknown>(response: AxiosResponse) => response.data;

export const get = <T = unknown>(url: string, headers = {}): Promise<T> => instance(headers).get(url).then(responseBody);
export const post = <T = unknown>(url: string, body: {}, headers = {}): Promise<T> => instance(headers).post(url, body).then(responseBody);
export const put = <T = unknown>(url: string, body: {}, headers = {}): Promise<T> => instance(headers).put(url, body).then(responseBody);
export const destroy = <T = unknown>(url: string, headers = {}): Promise<T> => instance(headers).delete(url).then(responseBody);
