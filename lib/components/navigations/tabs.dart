import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'tab_item.dart';
class Tabs extends StatefulWidget {

  final List<TabItem> tabs;
  final Function? onTabChanged;
   Tabs({Key? key, required this.tabs, this.onTabChanged}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  // store current active tab index
  int activeTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildTabItems(),
    );
  }

  void _onTabChanged(int index){
    // call set state to re-build this tab widgets
    setState(() {

      this.activeTabIndex = index;
      // emit function callback with the user clicked index number
      if(this.widget.onTabChanged != null){
        this.widget.onTabChanged!(index);
      }

    });
  }
  // take the tabs property and render all the tab item
  List<TabItem> _buildTabItems(){
    List<TabItem> tabs = List.of([]);
    widget.tabs.asMap().forEach((index, element) {
      // evaluate the active boolean by checking the current active tab index with the iteration index
      bool isActive = this.activeTabIndex ==  index;

      tabs.add(
        TabItem(
          title: element.title,
          active: isActive,
          onTap: ()  =>  this._onTabChanged( index)
        )
      );

    });

    return tabs;
  }
}
