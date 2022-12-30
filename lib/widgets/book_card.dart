import 'dart:math';

import 'package:book_shop/Constant.dart';
import 'package:book_shop/theme/colors.dart';
import 'package:flutter/material.dart';

import '../models/Book.dart';
import '../pages/book.dart';
import 'avatar_image.dart';

class BookCard extends StatelessWidget {
  BookCard({ Key? key, required this.book}) : super(key: key);
  Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()async{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BookDetail(file: book.data_file,id:book.id,image: book.image,desc: book.content,)),
        );
      },
      child: Container(
          width: 200,
          height: 255,
          margin: EdgeInsets.only(right: 25),
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5),

                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color:Colors.black26,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Image.network(book.image,
                    width: 80, height: 100
                  ),
                ),
              ),
              Text(book.title,
                maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                style:new TextStyle(fontFamily: 'cairo',
                  fontSize: 16.0,
                  color:const Color(0xFF21899C),

                )
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(text: book.price, style: new TextStyle(fontFamily: 'cairo',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color:const Color(0xFF21899C),
                      letterSpacing: 2.000000061035156,

                    )),

                  ]
                )
              )
            ],
          ),
        ),
    );
  }
}