import 'package:flutter/material.dart';

class ProxyTaskField extends StatelessWidget {
  const ProxyTaskField({super.key});

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
