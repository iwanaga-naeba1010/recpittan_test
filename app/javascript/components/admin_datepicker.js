import React, { useState, useEffect, useCallback } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { format, isValid } from 'date-fns';
import { ja } from "date-fns/locale";

const DATE_FORMAT = 'yyyy-MM-dd h:mm aa';

const AdminDatePicker = ({ name, id, value }) => {
  const parseDate = (val) => {
    if (val instanceof Date && isValid(val)) return val;

    if (typeof val === 'string') {
      const parsed = new Date(val);
      return isValid(parsed) ? parsed : null;
    }

    return null;
  };

  const [dateTime, setDateTime] = useState(parseDate(value));

  useEffect(() => {
    const hiddenInput = document.getElementById(`${id}_hidden`);
    if (hiddenInput) {
      hiddenInput.value = dateTime ? format(dateTime, DATE_FORMAT) : '';
    }
  }, [dateTime, id]);

  const onChange = useCallback((date) => setDateTime(date), []);

  return (
    <DatePicker
      selected={dateTime}
      onChange={onChange}
      dateFormat={DATE_FORMAT}
      showTimeSelect
      timeIntervals={15}
      timeFormat="h:mm aa"
      timeCaption="時間"
      locale={ja}
      customInput={<input type="text" id={id} name={name} className="react-datepicker-input" />}
    />
  );
};

export default AdminDatePicker;
