import 'package:book_shop/pages/books.dart';
import 'package:book_shop/pages/mybook.dart';
import 'package:book_shop/pages/qr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../theme/colors.dart';
import 'bottombar_item.dart';

Widget getBottomBar(String is_active, context) {
  return Container(
    height: 65,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(100),
      ),
      color: bottomBarColor,
    ),
    child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: BottomBarItem(Icons.home, "", isActive: is_active == 'home' ? true: false, activeColor: secondary),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BooksScreen()),
                  );
                },
                child: BottomBarItem(Icons.my_library_books_rounded, "", isActive: is_active == 'books' ? true: false, activeColor: secondary),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRViewer()),
                  );
                },
                child: BottomBarItem(Icons.qr_code, "", isActive:is_active == 'code' ? true: false, activeColor: secondary),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyBook()),
                  );
                },
                child: BottomBarItem(Icons.book, "", isActive: is_active == 'mybooks' ? true: false, activeColor: secondary),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyBook()),
                  );
                },
                child: BottomBarItem(Icons.settings, "", isActive: is_active == 'setting' ? true: false, activeColor: secondary),
              )
            ]
        )
    ),
  );
}
