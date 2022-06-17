export const getQeuryStringValueByKey = (key: string): string => {
  const search = window.location.search;
  const params = new URLSearchParams(search);
  return params.get(key);
};
