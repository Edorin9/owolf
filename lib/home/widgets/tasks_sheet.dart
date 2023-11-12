import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utility/hooks.dart';

const _minSize = 0.3;
const _maxSize = 1.0;
const _crossFadeThreshold = 0.4;

class TasksSheet extends HookWidget {
  const TasksSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final crossFadeState = useState(CrossFadeState.showFirst);
    final draggableScrollableController = useDraggableScrollableController();

    draggableScrollableController.addListener(() {
      final isWithinSizeLimitAndNotShowFirst =
          draggableScrollableController.size <= _crossFadeThreshold &&
              crossFadeState.value != CrossFadeState.showFirst;
      final isOutsideSizeLimitAndNotShowSecond =
          draggableScrollableController.size > _crossFadeThreshold &&
              crossFadeState.value != CrossFadeState.showSecond;
      if (isWithinSizeLimitAndNotShowFirst) {
        crossFadeState.value = CrossFadeState.showFirst;
      } else if (isOutsideSizeLimitAndNotShowSecond) {
        crossFadeState.value = CrossFadeState.showSecond;
      }
    });

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: _minSize,
        minChildSize: _minSize,
        maxChildSize: _maxSize,
        snap: true,
        controller: draggableScrollableController,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.36),
                  blurRadius: 4,
                  offset: const Offset(0, -2), // Shadow position
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                    firstCurve: Curves.easeIn,
                    secondCurve: Curves.easeOut,
                    crossFadeState: crossFadeState.value,
                    firstChild: Container(
                      color: Colors.black,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * _minSize,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(27),
                            hintText: 'Enter focus task',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 27,
                                ),
                            border: InputBorder.none,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: 27,
                                height: 1.5,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      ),
                    ),
                    secondChild: Column(
                      children: [
                        Container(
                          color: Colors.black,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                        ),
                        Container(
                          color: Colors.grey.shade900,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
