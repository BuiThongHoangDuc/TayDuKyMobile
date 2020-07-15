import 'package:flutter/material.dart';

class DestinationUser {
  const DestinationUser(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<DestinationUser> allDestinationUser = <DestinationUser>[
  DestinationUser('Scenario', Icons.movie_filter),
  DestinationUser('Scenario Have Done', Icons.history),
];