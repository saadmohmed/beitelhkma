import 'package:badges/badges.dart';
import 'package:book_shop/Wrapper.dart';
import 'package:book_shop/pages/home.dart';
import 'package:book_shop/pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/cupertino.dart';


import '../Constant.dart';
import '../models/Book.dart';
import '../services/ApiProvider.dart';
import '../theme/colors.dart';
import '../widgets/AppBar_helper.dart';
import 'book.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ApiProvider _api = new ApiProvider();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await   Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        return shouldPop!;
      },

      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:appbar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                FutureBuilder(
                    future: _api.getCart(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data as List;
                        return SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: 5),
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,

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
        floatingActionButton: FloatingActionButton(onPressed: ()async{
          ApiProvider _api = new ApiProvider();
          dynamic data = await _api.add_order();
          if(data["success"] == 1){
            final storage = new FlutterSecureStorage();
              dynamic token = data['token'];
              await storage.write(key: 'token', value: token);
            final api_token = await storage.read(
              key: 'api_token',
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PaymentScreen(token:token , api_token:api_token  , url:data['url'])),
            );
          }
        },child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text('اطلب'),
        ),),

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
          MaterialPageRoute(builder: (context) => BookDetail(file: book.data_file,id:book.id,image: book.image,desc: book.content,)),
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
