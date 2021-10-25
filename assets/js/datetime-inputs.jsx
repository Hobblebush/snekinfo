
import $ from 'cash-dom';
import flatpickr from "flatpickr";
import { parseISO, formatISO } from 'date-fns';

function setup() {
  $('.datetime-local-input').each((_ii, item) => {
    let conf = {
      enableTime: true,
      dateFormat: "Y-m-dTH:i",
      parseDate: (text, _format) => parseISO(text),
      formatDate: (date, _format, _locale) => formatISO(date),
    };
    flatpickr(item, conf);
  });
}

$(setup);
