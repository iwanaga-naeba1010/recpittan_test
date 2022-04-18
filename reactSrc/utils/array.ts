export const isEmpty = (arr: Array<unknown>): boolean =>
  arr === undefined || arr === null || arr.length === 0 ? true : false;
