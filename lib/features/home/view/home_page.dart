import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/extensions/duration_ext.dart';
import '../../break/view/break_page.dart';
import '../bloc/home_bloc.dart';
import '../enums/rest_option.dart';
import '../enums/work_mode.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String name = '/home';
  static WidgetBuilder route() => (context) => const HomePage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
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
                  _HeaderIcons(),
                  _Timer(),
                ],
              ),
            ),
            _ProxyTaskField(),
            // TODO(Edorin9): future - _DraggableTasksSheet(),
          ],
        ),
      ),
    );
  }
}

class _HeaderIcons extends StatelessWidget {
  const _HeaderIcons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoButton(
          onPressed: () => debugPrint('home'),
          child: Icon(
            CupertinoIcons.home,
            color: Colors.grey.shade900,
          ),
        ),
        CupertinoButton(
          onPressed: () => debugPrint('settings'),
          child: Icon(
            CupertinoIcons.settings,
            color: Colors.grey.shade900,
          ),
        ),
      ],
    );
  }
}

class _Timer extends StatelessWidget {
  const _Timer();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: // TODO(Edorin9): future - remove
            MainAxisAlignment.center,
        children: [
          // TODO(Edorin9): future - add SizedBox(
          //   height: MediaQuery.of(context).size.height / 7,
          // ),
          // timer display
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => Text(
              state.elapsedTime.timerFormat,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 81,
                    color: Colors.grey.shade900,
                  ),
            ),
          ),
          const SizedBox(height: 9),
          // play/stop button
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => CupertinoButton(
              onPressed: () async {
                final homeBloc = context.read<HomeBloc>();
                if (state.isRunning == false) {
                  // start timer
                  unawaited(homeBloc.initiateStopWatch());
                } else {
                  // show sheet to choose restOption
                  final restOption = await _showRestOptionSheet(context);
                  // handle chosen restOption
                  switch (restOption) {
                    case RestOption.takeBreak:
                      // cancel break if computed break duration is zero or less
                      if (homeBloc.state.breakDuration.inSeconds <= 0) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Time worked is not enough!'),
                              backgroundColor: Colors.red.shade900,
                            ),
                          );
                        }
                        return;
                      }
                      // stop timer - if mounted, start break timer
                      unawaited(homeBloc.resetStopwatch());
                      if (context.mounted) {
                        await Navigator.of(context).pushNamed(
                          BreakPage.name,
                          arguments: BreakArgs(
                            duration: homeBloc.state.breakDuration,
                            referenceMode: WorkMode.normal,
                          ),
                        );
                        unawaited(homeBloc.initiateStopWatch());
                      }
                      break;
                    case RestOption.endSession:
                      unawaited(homeBloc.resetStopwatch());
                      break;
                    case RestOption.cancel:
                      break;
                  }
                }
              },
              minSize: 0,
              child: Icon(
                state.isRunning == true
                    ? CupertinoIcons.stop_fill
                    : CupertinoIcons.play_arrow_solid,
                color: Colors.grey.shade900,
                size: 45,
              ),
            ),
          ),
          SizedBox(
            // TODO(Edorin9): future - remove
            height: MediaQuery.of(context).size.height / 9,
          ),
        ],
      ),
    );
  }

  Future<RestOption> _showRestOptionSheet(BuildContext context) async {
    return await showModalBottomSheet<RestOption>(
          context: context,
          isScrollControlled: true,
          builder: (_) => Padding(
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 16),
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    BlocBuilder<HomeBloc, HomeState>(
                      bloc: context.read<HomeBloc>(),
                      builder: (_, state) => RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: Colors.grey.shade900,
                                fontSize: 18,
                                height: 1.5,
                                fontWeight: FontWeight.w300,
                              ),
                          children: [
                            const TextSpan(text: 'Do you want to take a '),
                            // ignore: lines_longer_than_80_chars
                            TextSpan(
                              text:
                                  'break for ${state.breakDuration.inMinutes} minute${state.breakDuration.inMinutes > 1 ? 's' : ''} ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: 'or '),
                            const TextSpan(
                              text: 'end this session?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            // stop normal timer - start break countdown timer
                            Navigator.pop(context, RestOption.takeBreak);
                            // TODO(Edorin9): next - create break timer screen
                          },
                          child: Icon(
                            RestOption.takeBreak.icon,
                            color: Colors.grey.shade900,
                            size: 36,
                          ),
                        ),
                        Text(
                          '— OR —',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: Colors.grey.shade900,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            // stop normal timer
                            Navigator.pop(context, RestOption.endSession);
                          },
                          child: Icon(
                            RestOption.endSession.icon,
                            color: Colors.grey.shade900,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ) ??
        RestOption.cancel;
  }
}

class _ProxyTaskField extends StatelessWidget {
  const _ProxyTaskField();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.multiline,
        cursorColor: Colors.black,
        maxLines: null,
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(27),
          hintText: 'Enter focus task',
          hintStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: Colors.grey.shade500,
                fontSize: 27,
                height: 1.5,
                fontWeight: FontWeight.w300,
              ),
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: Colors.grey.shade900,
              fontSize: 27,
              height: 1.5,
              fontWeight: FontWeight.w300,
            ),
      ),
    );
  }
}

// TODO(Edorin9): future - class _DraggableTasksSheet extends HookWidget {
//   @override
//   Widget build(BuildContext context) {
//     final isCollapsed = useState(true);
//     final draggableScrollableController = useDraggableScrollableController();
//     draggableScrollableController.addListener(() {
//       if (draggableScrollableController.size >= 0.36 && isCollapsed.value) {
//         isCollapsed.value = false;
//       } else if (draggableScrollableController.size < 0.36 &&
//           !isCollapsed.value) {
//         isCollapsed.value = true;
//       }
//     });
//     return DraggableScrollableSheet(
//       initialChildSize: 1 / 3,
//       minChildSize: 1 / 3,
//       snap: true,
//       controller: draggableScrollableController,
//       builder: (BuildContext context, ScrollController scrollController) {
//         return DecoratedBox(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.36),
//                 blurRadius: 4,
//                 offset: const Offset(0, -2), // Shadow position
//               ),
//             ],
//           ),
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: AnimatedCrossFade(
//               duration: const Duration(milliseconds: 360),
//               reverseDuration: const Duration(milliseconds: 180),
//               firstCurve: Curves.easeIn,
//               secondCurve: Curves.easeOut,
//               crossFadeState: isCollapsed.value
//                   ? CrossFadeState.showFirst
//                   : CrossFadeState.showSecond,
//               firstChild: Container(
//                 color: Colors.grey.shade900,
//                 width: double.infinity,
//                 height: MediaQuery.of(context).size.height / 2,
//                 child: SizedBox(
//                   height: double.infinity,
//                   child: TextField(
//                     textAlign: TextAlign.center,
//                     keyboardType: TextInputType.multiline,
//                     maxLines: null,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.all(27),
//                       hintText: 'Enter focus task',
//                       hintStyle:
//                           Theme.of(context).textTheme.displayLarge?.copyWith(
//                                 color: Colors.white.withOpacity(0.5),
//                                 fontSize: 27,
//                               ),
//                       border: InputBorder.none,
//                     ),
//                     style: Theme.of(context).textTheme.displayLarge?.copyWith(
//                           color: Colors.white,
//                           fontSize: 27,
//                           height: 1.5,
//                           fontWeight: FontWeight.w300,
//                         ),
//                   ),
//                 ),
//               ),
//               secondChild: Column(
//                 children: [
//                   Container(
//                     color: Theme.of(context).canvasColor,
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height,
//                   ),
//                   Container(
//                     color: Colors.grey.shade900,
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
