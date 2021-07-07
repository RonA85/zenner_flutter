// import 'package:flutter/material.dart';
//
// class MultiAnswersWidget extends StatelessWidget {
//   final List<String> answers;
//   final Function<string>() onTap;
//
//   const MultiAnswersWidget({Key key, this.answers}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Column(
//       children: [
//         for (var answer in answers)
//           InkWell(onTap: onTap(a), child: _buildAnswer(answer)),
//       ],
//     );
//   }
//
//   Widget _buildAnswer(String answer) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding:
//               const EdgeInsets.only(right: 24, top: 16, bottom: 16, left: 24),
//           child: Row(
//             children: [
//               Text(
//                 answer,
//                 style: TextStyle(color: primary, fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ),
//         Divider()
//       ],
//     );
//   }
// }
