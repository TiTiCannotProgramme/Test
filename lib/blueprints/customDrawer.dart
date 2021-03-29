import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:expandable/expandable.dart';

import '../providers/constants.dart';
import 'CustomExpandablePanel.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [];
    for (PanelType value in PanelType.values) {
      myList.add(
        SizedBox(
          height: 3,
        ),
      );
      myList.add(
        CustomExpandablePanel(value),
      );
    }

    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: SafeArea(
          child: ExpandableTheme(
            data: const ExpandableThemeData(
              iconColor: Colors.blue,
              useInkWell: true,
            ),
            child: ListView(
              //physics: const BouncingScrollPhysics(),
              children: <Widget>[
                CircleAvatar(
                  radius: kDrawerWidth / 2.5,
                  backgroundImage: AssetImage("assets/images/pusheen.jpg"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                ...myList,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// bool firstPanelExpanded = false;
//
// ExpansionPanel firstPanel(SoundPageManager manager) {
//   return ExpansionPanel(
//     headerBuilder: (context, isExpanded) {
//       return Container(
//         color: Colors.red,
//         width: double.infinity,
//         padding: EdgeInsets.all(15),
//         alignment: Alignment.centerLeft,
//         child: Text('View Option'),
//       );
//     },
//     body: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Divider(),
//         GestureDetector(
//           child: Container(
//             //color: Colors.blue,
//             padding: EdgeInsets.all(10),
//             child: Text('List View'),
//           ),
//           onTap: () {
//             manager.changeToListView();
//             firstPanelExpanded = !firstPanelExpanded;
//           },
//         ),
//         Divider(),
//         GestureDetector(
//           child: Container(
//             padding: EdgeInsets.all(10),
//             child: Text('Page View'),
//           ),
//           onTap: () {
//             manager.changeToPageView();
//             firstPanelExpanded = !firstPanelExpanded;
//           },
//         ),
//       ],
//     ),
//     isExpanded: firstPanelExpanded,
//   );
// }

// ExpansionPanelList(
// expansionCallback: (int index, bool isExpanded) {
// setState(() {
// firstPanelExpanded = !firstPanelExpanded;
// });
// },
// children: [firstPanel(manager)],
// ),

// SingleChildScrollView(
// padding: EdgeInsets.only(top: 20),
// child: SafeArea(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// //mainAxisAlignment: MainAxisAlignment.start,
// children: [
// CircleAvatar(
// radius: kDrawerWidth/2.5,
// backgroundImage: AssetImage("assets/images/pusheen.jpg"),
// ),
// SizedBox(height: 20,),
// ],
// ),
// ),
// ),
