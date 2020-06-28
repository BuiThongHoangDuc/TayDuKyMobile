import 'package:flutter/material.dart';

class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> allDestination = <Destination>[
  Destination('Scenario', Icons.movie_filter),
  Destination('Actor', Icons.supervisor_account),
  Destination('Equipment', Icons.subject),
];