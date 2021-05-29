import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/src/models/add_model.dart';
import 'package:woin/src/presentation/mainTabs/CardsProductView.dart';
import 'package:woin/src/providers/add_providers.dart';

class SwipersCard extends StatefulWidget {
  @override
  _SwipersCardState createState() => _SwipersCardState();
}

class _SwipersCardState extends State<SwipersCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 27.0.h,
      child: FutureBuilder<List<AddModel>>(
        future: AddProvider().getAllAdds(context),
        builder: ( context, snapshot) {
          if (!snapshot.hasData) return Container(child: Center(child: CircularProgressIndicator()));
          if(snapshot.data.length == 0) return Center(child: Text("No hay anuncions disponibles"));
          return Container(
            height: 25.0.h,
            width: 100.0.w,
            child: Swiper(
              itemBuilder: (BuildContext context,int index) => CardProductView(
                addModel: snapshot.data[index] ,
                index:index
              ), 
              itemCount: snapshot.data.length,
              itemWidth: 95.0.w,
              itemHeight: 25.0.h,
              autoplay: true,
              duration: 900,
              autoplayDelay: 7000,
              layout: SwiperLayout.STACK,
              scrollDirection: Axis.horizontal,
              key: GlobalKey(),
            ),
          );
        },
      ),
    );
  }
}