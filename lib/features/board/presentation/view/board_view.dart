// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vignette__mobile/features/board/presentation/view_model/board/board_bloc.dart';

// class BoardView extends StatelessWidget {
//   const BoardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       // create: (context) => BoardBloc(/* pass your data source */),
//       child: Scaffold(
//         appBar: AppBar(
//           leading:
//               const Icon(Icons.check, size: 30), // Placeholder for app logo
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.file_upload),
//               onPressed: () => _showExportOptions(context),
//             ),
//             PopupMenuButton<String>(
//               icon: const Icon(Icons.menu),
//               itemBuilder: (context) => [
//                 const PopupMenuItem(
//                   value: 'option1',
//                   child: Text('Option 1'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'option2',
//                   child: Text('Option 2'),
//                 ),
//               ],
//               onSelected: (value) {
//                 // Handle menu selection
//               },
//             ),
//           ],
//         ),
//         body: Stack(
//           children: [
//             // Canvas or content area
//             Container(
//               color: Colors.white,
//               child: const Center(
//                 child: Text(
//                   'Board View',
//                   style: TextStyle(fontSize: 18, color: Colors.black54),
//                 ),
//               ),
//             ),

//             // Bottom toolbar
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // IconButton(
//                     //   icon: const Icon(Icons.add),
//                     //   onPressed: () {
//                     //     // Add new text
//                     //     context.read<BoardBloc>().add(
//                     //           CreateBoardEvent(),
//                     //         );
//                     //   },
//                     // ),
//                     IconButton(
//                       icon: const Icon(Icons.image),
//                       onPressed: () {
//                         // Add an image
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.edit),
//                       onPressed: () {
//                         // Add doodle/sketch functionality
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.mic),
//                       onPressed: () {
//                         // Add voice recording
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.text_fields),
//                       onPressed: () {
//                         // Add text field
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showExportOptions(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Export as'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 title: const Text('PNG'),
//                 onTap: () {
//                   // Handle PNG export
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('JPEG'),
//                 onTap: () {
//                   // Handle JPEG export
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: const Text('PDF'),
//                 onTap: () {
//                   // Handle PDF export
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
