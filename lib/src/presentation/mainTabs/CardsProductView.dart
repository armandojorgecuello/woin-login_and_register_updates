import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:sizer/sizer.dart';

import 'package:woin/src/models/add_model.dart';

class CardProductView extends StatefulWidget {
  final AddModel addModel;
  final int index;

  const CardProductView({Key key, this.addModel, @required this.index}) : super(key: key);

  @override
  _CardProductViewState createState() => _CardProductViewState();
}

class _CardProductViewState extends State<CardProductView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:3.0.w ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal:2.0.w ),
        width: 95.0.w,
        height: 25.0.h,
        child: Row(
          children: [
            _cardImage(),
            SizedBox(width: 2.0.w,),
            Container(height: 25.0.h, child: VerticalDivider(color: Colors.grey[500]), width: 0.08.w,),
            SizedBox(width: 2.0.w,),
            _cardInfo(context)
          ],
        )
      ),
    );
  }

  Container _cardInfo(context) {
    return Container(
      width: 38.5.w,
      height: 25.0.h,
      child: Column(
        children:[
          _cardContainer(context),
        ]
      )
    );
  }

  FadeInImage _cardImage() {
    return FadeInImage(
      placeholder: AssetImage("assets/loading_image.gif"),
      image: widget.addModel?.multimedia != null ? NetworkImage(widget.addModel?.multimedia) : AssetImage("assets/no_image.jpeg"),
      fit: BoxFit.cover,
      height: 41.0.w,
      width: 41.0.w,
    );
  }

 
  Container _cardContainer(BuildContext context) {
    return Container(
      height: 25.0.h,
      width: 38.0.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height:1.0.h,
          ),
          Container(
            width:43.0.w,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color:Colors.orange
                  ),
                  width: 25.0.w,
                  padding: EdgeInsets.all(0.5.w),
                  child: Text("${widget.index}" ?? "", style: TextStyle(fontSize:11.0.sp, color:Colors.white)),
                ),
                Expanded(child:Container()),
                InkWell(
                  child: Icon(LineIcons.heart, color:  Colors.grey,)
                )
              ],
            ),
          ),
          SizedBox(
            height:1.0.h,
          ),
          Container(
            width:42.0.w,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 4.5.w,
                ),
                SizedBox(width:1.0.w),
                Container(
                  width: 27.0.w,
                  child: Text(widget.addModel?.title ?? "", style: TextStyle(fontSize:9.5.sp))
                ),
              ],
            ),
          ),
          SizedBox(
            height:1.0.h,
          ),
          Container(
            width:42.0.w,
            child: Text(widget.addModel?.description ?? "", style:TextStyle(fontSize:9.5.sp), maxLines: 1, overflow: TextOverflow.ellipsis)
          ),
          SizedBox(
            height:0.5.h,
          ),
          Container(
            width:42.0.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(1.0.w),
                  child: Text("${widget.addModel?.price}" ?? "", style:TextStyle(fontSize:13.0.sp, color:Color(0xff015a88), fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis)
                ),
                SizedBox(width:1.0.w),
                widget.addModel.discountPercentage > 0 ? Text("${widget.addModel?.discountPercentage}" ?? "", style:TextStyle(fontSize:9.0.sp, color:Color(0xff4ab8db)), maxLines: 1, overflow: TextOverflow.ellipsis): Container(),
                widget.addModel.discountPercentage > 0 ? Text("% dto", style:TextStyle(fontSize:9.0.sp,color:Color(0xff4ab8db)) ,) : Container(),
              ],
            )
          ),
          Container(
            width:42.0.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(LineIcons.gift, size: 9.0.sp),
                Text("${widget.addModel?.price}" ?? "", style:TextStyle(fontSize:10.0.sp, color:Color(0xff4ab8db), ), maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            )
          ),
          Container(
            width: 42.0.w,
            child: Row(
              children: [
                Text("Envio gratis", style:TextStyle(fontSize:10.0.sp, color:Color(0xff4ab8db)), maxLines: 1, overflow: TextOverflow.ellipsis),
                Expanded(child:Container()),
                Icon(LineIcons.car, color:  Colors.grey,),
              ],
            )
          ),
        ],
      )
    );
  }
}
