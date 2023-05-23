export const getQeuryStringValueByKey = (key: string): string | undefined => {
  const search = window.location.search;
  const params = new URLSearchParams(search);
  const value = params.get(key);
  return value !== null ? value : undefined;
};


export const removeQueryStringsByKey = (): void => {
  const url = window.location.href;
  const splitedUrl = url.split('?')[0];
  window.history.replaceState(null, '', splitedUrl);
};
