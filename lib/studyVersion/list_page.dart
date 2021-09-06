// list_page.dart

import "package:flutter/material.dart";

class ListPage extends StatelessWidget {
  // ...
  @override
  Widget build(BuildContext context) {
    // 1-3. 리스트 화면 (초기 리스트 구현)
    return ListView(
        // 1
        children: <Widget>[
          // 2
          Padding(padding: EdgeInsets.all(8.0), child: Text("신과함께-죄와벌")),
          Padding(padding: EdgeInsets.all(8.0), child: Text("저스티스 리그")),
          Padding(padding: EdgeInsets.all(8.0), child: Text("토르:라그나로크")),
          Padding(padding: EdgeInsets.all(8.0), child: Text("러빙 빈센트")),
          Padding(padding: EdgeInsets.all(8.0), child: Text("범죄도시")),
          Padding(padding: EdgeInsets.all(8.0), child: Text("꾼")),
          Padding(padding: EdgeInsets.all(8.0), child: Text("쥬만지: 새로운 세계")),
          Padding(padding: EdgeInsets.all(8.0), child: Text("뽀로로 극장판 공룡섬 대모험"))
        ]);
    ///////////////////////////////////////////////////////////////////////////////
  }
}
