import moment from 'moment';

export const prettyHM = (date: Date): string => moment(date).format("HH:mm");
// export const prettyHM = (date: Date): string => moment(date).format("YYYY-MM-DD HH:mm");
