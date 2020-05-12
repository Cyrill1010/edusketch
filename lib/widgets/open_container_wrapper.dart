import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper(
      {this.closedBuilder,
      this.transitionType,
      this.transitionDuration,
      this.destinationRoute});

  final OpenContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final Duration transitionDuration;
  final Widget destinationRoute;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: transitionDuration,
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return destinationRoute;
      },
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}
