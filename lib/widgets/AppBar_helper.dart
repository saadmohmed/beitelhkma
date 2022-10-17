import 'package:badges/badges.dart';
import 'package:book_shop/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Wrapper.dart';
import '../services/ApiProvider.dart';
import '../theme/colors.dart';

    AppBar appbar(context) {
     return   AppBar(
       backgroundColor: primary,
       leading: IconButton(icon:Icon(Icons.arrow_back) , onPressed: ()async {
         Navigator.pushReplacement(
           context,
           MaterialPageRoute(builder: (context) => Wrapper()),
         );        },),
       // backgroundColor: Colors.transparent,
       elevation: 0,
       title: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           // Expanded(
           //     child: Container(
           //         alignment: Alignment.centerLeft,
           //         child: Icon(
           //           Icons.vertical_distribute_rounded,
           //         ))),
           // Icon(Icons.search_rounded),
           SizedBox(
             width: 10,
           ),
           GestureDetector(onTap:()async {
             ApiProvider _api  = new ApiProvider();
             await _api.logout();
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => Wrapper()),
             );              } ,child: Icon(Icons.logout)),

         ],
       ),
     );
    }




