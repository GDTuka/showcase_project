import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  addHabbit('addHabbit'),
  auth('auth'),
  home('home'),
  profile('profile'),
  settings('settings');

  // ignore: unused_element, unused_element_parameter
  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
    Routes.addHabbit => const Text('Add Habbit'),
    Routes.auth => const Text('Auth'),
    Routes.home => const Text('Home'),
    Routes.profile => const Text('Profile'),
    Routes.settings => const Text('Settings'),
  };
}
