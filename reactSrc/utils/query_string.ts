export const getQeuryStringValueByKey = (key: string): string | null => {
  const search = window.location.search;
  const params = new URLSearchParams(search);
  return params.get(key);
};

export const removeQueryStringsByKey = (): void => {
  const url = window.location.href;
  const splitedUrl = url.split('?')[0];
  window.history.replaceState(null, '', splitedUrl);
};
