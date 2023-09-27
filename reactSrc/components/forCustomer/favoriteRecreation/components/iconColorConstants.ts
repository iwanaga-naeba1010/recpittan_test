export const FAVORITE_COLOR = 'rgb(255, 48, 64)';
export const DEFAULT_COLOR = 'none';
export const DEFAULT_STROKE_COLOR = '#6C757D';

export const getStrokeColor = (isFavorite: boolean): string => isFavorite ? FAVORITE_COLOR : DEFAULT_STROKE_COLOR;
