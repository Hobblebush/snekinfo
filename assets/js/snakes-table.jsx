import $ from 'cash-dom';
import { concat, sortBy } from 'lodash';
import { setIn } from 'lodash-redux-immutability';
import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import { Button, Form, Row, Col } from 'react-bootstrap';
import {
  XSquare, SortAlphaDown, SortNumericDown, SortNumericUp
} from 'react-bootstrap-icons';

function SnakesTable({snakes}) {
  const [conf, setConf] = useState({
    sorting: ['name', 'species', 'weight'],
    filters: {},
  });

  let controlsRow = (
    <ControlsRow key="controls" conf={conf} setConf={setConf} />
  );
  let vizSnakes = snakes.filter((snake) => keepSnake(snake, conf.filters));
  let snakeRows = sortBy(vizSnakes, conf.sorting).map((snake) =>
    <SnakeRow snake={snake} key={snake.id} />);
  let rows = concat([controlsRow], snakeRows);

  return (
    <table className="table table-striped">
      <thead>
        <tr>
          <th>Name</th>
          <th>Species</th>
          <th>Sex</th>
          <th>Born</th>
          <th>Weight</th>
          <th>Last Fed</th>
          <th>Litter</th>
          <th>Traits</th>
          <th>Edit</th>
        </tr>
      </thead>
      <tbody>
        {rows}
      </tbody>
    </table>
  );
}

function keepSnake(snake, filters) {
  for (const [kk, vv] of Object.entries(filters)) {
    if (!snake[kk].toLowerCase().includes(vv.toLowerCase())) {
      return false;
    }
  }
  return true;
}

function ControlsRow({conf, setConf}) {
  function setFilter(kk, val) {
    setTimeout(() => {
      let conf1 = setIn(conf, ['filters', kk], val);
      setConf(conf1);
    }, 10);
  }

  function filter(field) {
    return (ev) => {
      ev.preventDefault();
      setFilter(field, ev.target.value);
    };
  }

  function clearFilter(field) {
    return () => {
      let id = "control-input-" + field;
      let control = document.getElementById(id);
      if (control) {
        control.value = "";
      }
      setFilter(field, "");
    };
  }

  function pushSort(field) {
    return () => {
      let xs = conf.sorting.filter((xx) => xx != field);
      let ys = concat([field], xs);
      let conf1 = setIn(conf, ['sorting'], ys);
      setConf(conf1);
    };
  }

  return (
    <tr>
      <td>
        <Row>
          <Col sm={6}>
            <Form.Control id="control-input-name"
                          type="text" onChange={filter('name')} />
          </Col>
          <Col sm={4} className="text-nowrap">
            <Button variant="warning" onClick={clearFilter('name')}>
              <XSquare />
            </Button>
            <Button variant="secondary" onClick={pushSort('name')}>
              <SortAlphaDown />
            </Button>
          </Col>
        </Row>
      </td>
      <td>
        <Button variant="secondary" onClick={pushSort('species_name')}>
          <SortAlphaDown />
        </Button>
      </td>
      <td>
        <Button variant="secondary" onClick={pushSort('sex')}>
          <SortAlphaDown />
        </Button>
      </td>
      <td>
        <Button variant="secondary" onClick={pushSort('born')}>
          <SortAlphaDown />
        </Button>
      </td>
      <td className="text-nowrap">
        <Button variant="secondary" onClick={pushSort('weight')}>
          <SortNumericDown />
        </Button>
        <Button variant="secondary" onClick={pushSort('weight_inv')}>
          <SortNumericUp />
        </Button>
      </td>
      <td>
        <Button variant="secondary" onClick={pushSort('last_feed')}>
          <SortNumericDown />
        </Button>
      </td>
      <td>
        <Button variant="secondary" onClick={pushSort('litter')}>
          <SortAlphaDown />
        </Button>
      </td>
      <td>
        <Row>
          <Col sm={6}>
            <Form.Control id="control-input-name"
                          type="text" onChange={filter('trait_names')} />
          </Col>
          <Col sm={4} className="text-nowrap">
            <Button variant="warning" onClick={clearFilter('trait_names')}>
              <XSquare />
            </Button>
          </Col>
        </Row>
      </td>
      <td>&nbsp;</td>
    </tr>
  );
}

function SnakeRow({snake}) {
  let species_link = "∅";
  if (snake.species) {
    species_link = <a href={snake.species.path}>{snake.species.name.split(/\s+/)[0]}</a>;
  }

  let weight_link = "∅";
  if (snake.weights[0]) {
    weight_link = <a href={snake.weights[0].path}>{snake.weights[0].weight}</a>;
  }

  let feeds_link = "∅";
  if (snake.feeds[0]) {
    feeds_link = <a href={snake.feeds[0].path}>{snake.feeds[0].date}</a>;
  }

  let litter_link = "∅";
  if (snake.litter) {
    litter_link = <a href={snake.litter.path}>{snake.litter.name}</a>;
  }

  let sorted_traits = sortBy(snake.traits, (trait) => trait.name);
  let traits_links = sorted_traits.map((trait) =>
    <TraitLink key={trait.id} trait={trait} />
  );

  return (
    <tr>
      <td><a href={snake.path}>{snake.name}</a></td>
      <td>{species_link}</td>
      <td>{snake.sex}</td>
      <td>{snake.born}</td>
      <td>{weight_link}</td>
      <td>{feeds_link}</td>
      <td>{litter_link}</td>
      <td>{traits_links}</td>
      <td><a href={snake.path+"/edit"}>Edit</a></td>
    </tr>
  );
}

function TraitLink({trait}) {
  return (
    <span style={{marginRight: "1ex"}}>
      <a href={trait.path}>{trait.name.replaceAll(" ", "\u00A0")} </a>
    </span>
  );
}

function normalizeSnakes(xs) {
  return xs.map((sn0) => {
    let sn1 = Object.assign({}, sn0);
    sn1.species_name = sn0.species?.name || "∅";
    sn1.weight = sn0.weights[0]?.weight || "∅";
    sn1.weight_inv = -sn1.weight;
    sn1.last_feed = sn0.feeds[0]?.date || "0";
    sn1.litter_name = sn0.litter?.name || "∅"
    sn1.trait_names = sn0.traits.map((tr) => tr.name).join(" ");
    return sn1;
  });
}

$(() => {
  let root = document.getElementById('snakes-table-root');
  if (root && window.snakes) {
    let snakes = normalizeSnakes(window.snakes);
    ReactDOM.render(<SnakesTable snakes={snakes} />, root);
  }
});
