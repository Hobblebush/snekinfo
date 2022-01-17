
import $ from 'cash-dom';
import { Converter } from 'showdown';

function render_markdown() {
  $('.markdown').each((_ii, elem) => {
    let conv = new Converter();
    let html = conv.makeHtml(elem.innerHTML);
    elem.innerHTML = html;
    $(elem).removeClass('markdown');
  });
}

$(render_markdown);
