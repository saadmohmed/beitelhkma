import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../Constant.dart';
import '../models/Book.dart';
import '../services/ApiProvider.dart';
import '../theme/colors.dart';
import '../widgets/AppBar_helper.dart';
import 'book.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  ApiProvider _api = new ApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:appbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
           FutureBuilder(
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
        }),         ],
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
    double _width = 150, _height = 150;
    return GestureDetector(
      onTap: ()async{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BookDetail(file: book.data_file,id:book.id,image: book.image,desc: book.content,)),
        );
      },
      child: Container(
          margin: EdgeInsets.only(right: 15),
          child: Column(
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
              Text(book.price, style: TextStyle(fontWeight: FontWeight.w500),)
            ],
          )
      ),
    );
  }
}
