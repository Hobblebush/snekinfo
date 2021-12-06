import $ from 'cash-dom';
import { sortBy } from 'lodash';
import React, { useState } from 'react';
import ReactDOM from 'react-dom';

function SnakesTable({snakes}) {
  let rows = snakes.map((snake) => <SnakeRow snake={snake} key={snake.id} />);

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

$(() => {
  let root = document.getElementById('snakes-table-root');
  if (root && window.snakes) {
    ReactDOM.render(<SnakesTable snakes={window.snakes} />, root);
  }
});
