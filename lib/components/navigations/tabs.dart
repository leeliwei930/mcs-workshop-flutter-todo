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

  int activeTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildTabItems(),
    );
  }

  void _onTabChanged(int index){
    setState(() {

      this.activeTabIndex = index;

      if(this.widget.onTabChanged != null){
        this.widget.onTabChanged!(index);
      }

    });
  }

  List<TabItem> _buildTabItems(){
    List<TabItem> tabs = List.of([]);
    widget.tabs.asMap().forEach((index, element) {
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
