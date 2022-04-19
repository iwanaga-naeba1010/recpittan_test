import moment from 'moment';

export const prettyHM = (date: Date): string => moment(date).format('HH:mm');
