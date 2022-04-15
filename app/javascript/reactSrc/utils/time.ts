import moment from 'moment';

export const prettyDate = (date: Date): string => moment(date).format("YYYY-MM-DD HH:mm");
