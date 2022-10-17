import 'dart:ui';
import 'package:book_shop/Wrapper.dart';
import 'package:book_shop/data/json.dart';
import 'package:book_shop/services/ApiProvider.dart';
import 'package:book_shop/theme/colors.dart';
import 'package:book_shop/widgets/avatar_image.dart';
import 'package:book_shop/widgets/book_card.dart';
import 'package:book_shop/widgets/book_cover.dart';
import 'package:flutter/material.dart';

import '../models/Book.dart';
import '../widgets/AppBar_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiProvider _api = new ApiProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:appbar(context),
      body: getStackBody(),
    );
  }

  getTopBlock() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
              color: primary),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 35, right: 15),
                child: FutureBuilder(
                    future: _api.getName(),
                    builder: (context, snapshot) { return Text(
                    snapshot.data.toString(),
                    style: TextStyle(
                        color: secondary,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  );},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 35, right: 15),
                child: Text(
                  "اهلا بك في معرض الكتاب",
                  style: new TextStyle(fontFamily: 'cairo',
                    fontSize: 25.0,
                    color: Colors.white,

                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    "الكتب المشهوره",
                    style: new TextStyle(fontFamily: 'cairo',
                      fontSize: 20.0,
                      color:Colors.white70,

                    ),
                  )),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          color: primary,
          child: Container(
            decoration: BoxDecoration(
                color: appBgColor,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(100))),
          ),
        )
      ],
    );
  }

  getStackBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  child: getTopBlock(),
                ),
                Positioned(
                  top: 180,
                  left: 0, right: 0,
                  child: Container(
                    height: 260,
                    child: getPopularBooks(),
                  )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Text(
                    "اخر الاصدرات",
                    style: new TextStyle(fontFamily: 'cairo',
                      fontSize: 23.0,
                      color:const Color(0xFF21899C),

                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: getLatestBooks(),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }


  getPopularBooks() {
    ApiProvider _api = new ApiProvider();
    return FutureBuilder(
        future: _api.getBooks('popular',10),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List;

            return  SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 5, left: 15),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(data.length,
                        (index) => BookCard(book: data[index])),
              ),
            );
          } else {

            return Center(child: CircularProgressIndicator());
          }
        });
  }

  getLatestBooks() {
    ApiProvider _api = new ApiProvider();
    return FutureBuilder(
        future: _api.getBooks('latest',10),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data as List;

            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 5),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    data.length, (index) => BookCover(book: data[index])),
              ),
            );
          } else {

            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
