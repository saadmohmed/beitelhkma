
import 'package:badges/badges.dart';
import 'package:book_shop/data/json.dart';
import 'package:book_shop/theme/colors.dart';
import 'package:book_shop/widgets/book_item.dart';
import 'package:flutter/material.dart';

import '../services/ApiProvider.dart';
import '../widgets/AppBar_helper.dart';
import '../widgets/book_cover.dart';

class BookPage extends StatefulWidget {
  const BookPage({ Key? key }) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  
  @override
  Widget build(BuildContext context) {
    return 
      body(context);
  }

  Widget body(context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar:appbar(context),

          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: TabBar(
                  indicatorColor: primary,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primary,
                  ),
                  labelPadding: EdgeInsets.only(top: 8, bottom: 8),
                  unselectedLabelColor: primary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [

                    Text( "الكتب الجديدة", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    Text( "الكتب المشهورة", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 15, right:15),
                      children: getNewBooks()
                    ),
                    ListView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(left: 15, right:15),
                      children: getPopularBooks()
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  getNewBooks(){
    return
      List.generate(latestBooks.length, (index) => 
        BookItem(book: latestBooks[index])
      );
  }
  
  getPopularBooks(){
    return
      List.generate(popularBooks.length, (index) => BookItem(book: popularBooks[index]));
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