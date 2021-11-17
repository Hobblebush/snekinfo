import $ from 'cash-dom';
import { includes } from 'lodash';
import React, { useState, useEffect } from 'react';
import ReactDOM from 'react-dom';

function get_trait(id) {
  for (let trait of window.snekinfo.traits) {
    if (+id == +trait.id) {
      return trait;
    }
  }
  return null;
}

function list_traits_for(spc_id, excl = []) {
  let ts = excl.map((xx) => +xx);
  return window.snekinfo.traits.filter((trait) => (
    (trait.species_id == spc_id) && !includes(ts, trait.id)
  ));
}

function Traits({field, val0, spc0}) {
  let [spcId, setSpcId] = useState(spc0);
  let [traits, setTraits] = useState(val0);

  useEffect(() => {
    $('#snake_species_id').on('change', (ev) => {
      setSpcId($(ev.target).val());
    });
    return (() => {
      $('#snake_species_id').off('change');
    });
  }, []);

  function set_spc_traits(xs) {
    $('#snake_traits').val(xs);
    let t1 = Object.assign({}, traits);
    t1[spcId] = xs;
    setTraits(t1);
  }

  let spc_traits = traits[spcId]||[];

  let pills = spc_traits.map((trait_id) => {
    let trait = get_trait(trait_id);

    function remove_trait(ev) {
      ev.preventDefault();
      let xs = traits[spcId]||[];
      let ys = xs.filter((xx) => xx != trait_id);
      set_spc_traits(ys);
    }

    return (
      <span key={trait.id} className="badge bg-secondary trait-badge">
        {trait.name} <a href="#" onClick={remove_trait}>×</a>
      </span>
    )
  });

  if (pills.length == 0) {
    pills = "(none)";
  }

  let listItems = list_traits_for(spcId, spc_traits).map((trait) => (
    <option key={trait.id} value={trait.id}>{trait.name}</option>
  ));

  function add_trait(ev) {
    ev.preventDefault();
    let xs = traits[spcId]||[];
    $('#next-trait').each((_ii, select) => {
      xs.push($(select).val());
    });
    set_spc_traits(xs);
  }

  function key_press(ev) {
    if (ev.key == "Enter") {
      add_trait(ev);
    }
  }

  return (
    <div>
      <label>Traits</label>
      <div className="row">
        <div className="col-sm-4 trait-pills">
          { pills }
        </div>
        <div className="col-sm-4">
          <select className="form-control" id="next-trait" onKeyPress={key_press}>
            { listItems }
          </select>
        </div>
        <div className="col-sm-4">
          <button className="btn btn-secondary" onClick={add_trait}>Add Trait</button>
        </div>
      </div>
    </div>
  );
}

function load() {
  $('#snake_traits').each((_ii, field) => {
    let root = document.getElementById('trait-root');
    let spc0 = $('#snake_species_id').val();
    let val0 = {};
    val0[spc0] = $(field).val();
    ReactDOM.render(<Traits field={field} val0={val0} spc0={spc0} />, root);
  });
  $('#trait-container').hide();
}

$(load);
