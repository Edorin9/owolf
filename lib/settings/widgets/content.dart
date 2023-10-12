import 'package:flutter/material.dart';

import 'widgets.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.black,
          child: ListView(
            children: const [
              ModeSection(),
              FluidSection(),
              PeriodicSection(),
            ],
          ),
        ),
      ),
    );
  }
}
