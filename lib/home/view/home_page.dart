import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  HeaderActions(),
                  Timer(),
                ],
              ),
            ),
            ProxyTaskField(),
            // TODO(Edorin9): future - _DraggableTasksSheet(),
          ],
        ),
      ),
    );
  }
}
