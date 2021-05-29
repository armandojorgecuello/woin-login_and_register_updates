import 'package:flutter/material.dart';
class OptionItem{
  final Widget startIcon;
  final Widget endIcon;
  final Widget title;
  final bool centerTitle;
  final Widget description;
  final CrossAxisAlignment alignContent;
  final Function onTap;

  OptionItem({@required this.startIcon, this.endIcon, @required this.title, this.centerTitle = false, @required this.description, this.alignContent = CrossAxisAlignment.start, @required this.onTap});
}
class OptionItemList{
  final List<OptionItem> list;
  final Widget title;
  OptionItemList({@required this.list, this.title});
}

class ItemList extends StatelessWidget {
  final List<OptionItemList> optionsItems;
  final Widget header;
  ItemList({Key key, @required this.optionsItems, this.header}) : super(key: key);

  Widget headerList(){
    return this.header??Container();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      children: List.generate(this.optionsItems.length+1, (int indexListView){
        return indexListView==0?headerList():Column(
          children: List.generate(this.optionsItems[indexListView-1].list.length+1, (int indexColumn){
            return indexColumn==0?Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: this.optionsItems[indexListView-1].title??Container()
        ):Card(
          margin: EdgeInsets.only(bottom: 15.0),
          elevation: 5.0,
          child: Container(
            width: size.width * 1,
            height: size.height * 0.1,
            padding: EdgeInsets.symmetric(horizontal:10.0),
            child: FittedBox(
                          child: InkWell(
                onTap: this.optionsItems[indexListView-1].list[indexColumn-1].onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    this.optionsItems[indexListView-1].list[indexColumn-1].startIcon??Container(),
                    SizedBox(width: size.width*0.05,),
                    Container(
                      width: size.width * 0.8,
                      child: Column(
                        crossAxisAlignment: this.optionsItems[indexListView-1].list[indexColumn-1].alignContent,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          // Container(
                          //   height: size.height*0.045,
                          //   child: this.optionsItems[indexListView-1].list[indexColumn-1].title,
                          // ),
                          this.optionsItems[indexListView-1].list[indexColumn-1].title,
                          this.optionsItems[indexListView-1].list[indexColumn-1].description??Container(),
                        ],
                      ),
                    ),
                    this.optionsItems[indexListView-1].list[indexColumn-1].endIcon??Container(),
                  ],
                ),
              ),
            )
          ),
        );
          })
        );
      })
    );
  }
}