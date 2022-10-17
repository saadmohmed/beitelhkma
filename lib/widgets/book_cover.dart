import 'dart:math';

import 'package:book_shop/Constant.dart';
import 'package:book_shop/pages/book.dart';
import 'package:book_shop/theme/colors.dart';
import 'package:flutter/material.dart';

import '../models/Book.dart';
import '../pages/book_review.dart';
import 'avatar_image.dart';

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
            Text(book.price, style: TextStyle(fontFamily: 'cairo',
              fontSize: 16.0,
              color:const Color(0xFF21899C),

            ),)
          ],
        )
      ),
    );
  }
}