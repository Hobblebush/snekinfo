
import $ from 'cash-dom';
import { trim } from 'lodash';
import { parseISO, format } from 'date-fns';

function format_dates() {
  $('.pretty-date').each((_ii, elem) => {
    try {
      let text = trim($(elem).text());
      let date = parseISO(text);
      $(elem).removeClass('pretty-date');
      $(elem).text(format(date, 'yyyy MMM dd'));
    }
    catch (_ee) {
      // skip
    }
  });

  $('.pretty-date-time').each((_ii, elem) => {
    try {
      let text = trim($(elem).text());
      let date = parseISO(text);
      $(elem).removeClass('pretty-date-time');
      $(elem).text(format(date, 'yyyy MMM dd, kk:mm'));
    }
    catch (_ee) {
      // skip
    }
  });
}

$(format_dates);
