
import $ from 'cash-dom';
import { trim } from 'lodash';
import { parseISO, format } from 'date-fns';

function format_dates() {
  $('.pretty-date').each((_ii, elem) => {
    let text = trim($(elem).text());
    let date = parseISO(text);
    $(elem).removeClass('pretty-date');
    $(elem).text(format(date, 'yyyy MMM dd'));
  });

  $('.pretty-date-time').each((_ii, elem) => {
    let text = trim($(elem).text());
    let date = parseISO(text);
    $(elem).removeClass('pretty-date-time');
    $(elem).text(format(date, 'yyyy MMM dd, kk:mm'));
  });
}

$(format_dates);
