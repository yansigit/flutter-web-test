// // main_page.dart

// import "package:flutter/material.dart";
// import 'package:flutter_dalbbodre/list_page.dart';
// // 1-2. 탭 화면 (각 화면 import)

// /////////////////////////////

// class _MainPageState extends State<MainPage> {
//   int _selectedTabIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: _buildPage(_selectedTabIndex),
//         appBar: AppBar(title: Text('Movie'), actions: <Widget>[
//           PopupMenuButton<int>(
//             icon: Icon(Icons.sort),
//             onSelected: (value) {
//               if (value == 0) {
//                 print("예매율 순");
//               } else if (value == 1) {
//                 print("큐레이션");
//               } else {
//                 print("최신순");
//               }
//             },
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem(value: 0, child: Text("예매율순")),
//                 PopupMenuItem(value: 1, child: Text("큐레이션")),
//                 PopupMenuItem(value: 2, child: Text("최신순"))
//               ];
//             },
//           )
//         ]),
//         bottomNavigationBar: BottomNavigationBar(
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.view_list), title: Text('List')),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.grid_on),
//                 title: Text("Grid"),
//               )
//             ],
//             currentIndex: _selectedTabIndex,
//             onTap: (index) {
//               setState(() {
//                 // setState call build function
//                 _selectedTabIndex = index;
//                 print("$_selectedTabIndex Tab Clicked");
//               });
//             },
//         ),
    
  
// ///////////////////////////////////////
// }

// Widget _buildPage(index) {
//   if (index == 0) {
//     return ListPage();
//   }
//   // } else {
//   //   return GridPage();
//   // }
// }

// class MainPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MainPageState();
//   }
// }
