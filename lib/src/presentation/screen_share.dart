

// class ScreenShareWidget extends ConsumerWidget {
//   const ScreenShareWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final Widget contentTile =
//         VideoTileWidget.tileKind(tileKind: VideoTileKind.content);
//     Widget body;
//     final isReceivingScreenShare =
//         ref.watch(meetingControllerProvider).isReceivingScreenShare;
//     if (!isReceivingScreenShare) {
//       body = GestureDetector(
//         onDoubleTap: () => Navigator.popAndPushNamed(context, '/meeting'),
//         child: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Text('Screenshare is no longer active.'),
//             ),
//             Center(
//               child: Text(
//                 'Double tap to go back to meeting.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       body = Column(
//         children: [
//           Expanded(
//             child: SizedBox(
//               width: double.infinity,
//               child: GestureDetector(
//                 onDoubleTap: () =>
//                     Navigator.popAndPushNamed(context, '/meeting'),
//                 child: contentTile,
//               ),
//             ),
//           ),
//         ],
//       );
//     }

//     return WillPopScope(
//       onWillPop: () async {
//         await Navigator.popAndPushNamed(context, '/meeting');
//         return false;
//       },
//       child: Scaffold(
//         body: body,
//       ),
//     );
//   }
// }
