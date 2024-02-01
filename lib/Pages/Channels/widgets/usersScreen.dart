// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../ChannelController.dart';

// class UsersScreen extends GetView<ChannelCtr> {
//   const UsersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       height: double.infinity,
//       width: double.infinity,
//       child: GetBuilder<ChannelCtr>(builder: (context) {
//         return ListView.builder(
//           itemCount: controller.userList.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 // controller.gotoGroupChatRoom();
//               },
//               child: Card(
//                 elevation: 0,
//                 child: Container(
//                   padding: const EdgeInsets.only(left: 8),
//                   alignment: Alignment.centerLeft,
//                   height: 50,
//                   decoration: BoxDecoration(
//                       color: Colors.indigo,
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Row(
//                     children: [
//                       // const CircleAvatar(),
//                       // const SizedBox(width: 10),
//                       Text(controller.userList[index].userName!),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
