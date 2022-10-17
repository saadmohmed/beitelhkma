import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/Book.dart';
import '../services/ApiProvider.dart';
import '../widgets/AppBar_helper.dart';
import 'book_review.dart';

class MyBook extends StatefulWidget {
  const MyBook({Key? key}) : super(key: key);

  @override
  State<MyBook> createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {
  ApiProvider _api = new ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:appbar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              FutureBuilder(
                  future: _api.mybooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List;
                      return SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 5),
                        scrollDirection: Axis.horizontal,
                        child: Column(

                          children: List.generate(
                              data.length, (index) => BookCover(book: data[index])),
                        ),
                      );
                    } else {

                      return Center(child: CircularProgressIndicator());
                    }
                  }),         ],
          ),
        ),
      ),

    );
  }
}
class BookCover extends StatelessWidget {
  BookCover({ Key? key, required this.book }) : super(key: key);
  Book book;

  @override
  Widget build(BuildContext context) {
    double _width = 300, _height = 250;
    return GestureDetector(
      onTap: ()async{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BookViewer(book_url: book.data_file,)),
        );
      },
      child: Container(
          margin: EdgeInsets.only(right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 50, right: 40),
                      width: _width,
                      height: _height,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color:Colors.white10,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(1, 1), // changes position of shadow
                          ),
                        ],
                      ),

                    ),
                    Container(
                      width: _width, height: _height,
                      padding: EdgeInsets.all(8),
                      child: Image.network(book.image,

                      ),
                    )
                  ]
              ),
              SizedBox(height: 8,),
              Text(book.price, style:  TextStyle(
                fontFamily: 'cairo',
                fontSize: 15.0,
                color: Colors.blue,
                fontWeight: FontWeight.w800,
              ),)
            ],
          )
      ),
    );
  }
}
