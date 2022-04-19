export const toSnakecase = (s: string): string => s.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);
export const toCamelcase = (s: string): string =>
  s.replace(/([-_][a-z])/gi, ($1) => $1.toUpperCase().replace('-', '').replace('_', ''));
