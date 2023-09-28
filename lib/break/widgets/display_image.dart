import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/break_cubit.dart';

class DisplayImage extends StatelessWidget {
  const DisplayImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BreakCubit, BreakState, bool>(
      selector: (state) => state.status == BreakStateStatus.completed,
      builder: (context, isCompleted) {
        return Image.asset(
          'assets/coffee.png',
          height: 163,
          color: isCompleted ? Colors.white : Colors.black,
          colorBlendMode: BlendMode.srcATop,
        );
      },
    );
  }
}
