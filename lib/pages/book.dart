import 'package:book_shop/Animation/FadeAnimation.dart';
import 'package:book_shop/pages/book_review.dart';
import 'package:book_shop/services/ApiProvider.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Constant.dart';
import '../widgets/AppBar_helper.dart';

class BookDetail extends StatefulWidget {
  final String image;
  final String desc;
  final dynamic id;
  final dynamic file;

  const BookDetail({ Key? key, required this.image,required this.desc ,required this.file , required this.id}) : super(key: key);

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {

  dynamic message = '';



  @override
  Widget build(BuildContext context) {
    dynamic snackBar = SnackBar(
      content: Text(message),
    );
    return Scaffold(
      appBar:appbar(context),

      body: SingleChildScrollView(
        child: Hero(
          tag: 'red',
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white10,
                  blurRadius: 10,
                  offset: Offset(0, 10)
                )
              ]
            ),
            child: Stack(
              children: <Widget>[

                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child:  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.9),
                          Colors.black.withOpacity(.0),
                        ]
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 25,),
                        SizedBox(height: 10,),
                       Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: GestureDetector(
                            onTap: () async{
                                 ApiProvider _api = new ApiProvider();
                                dynamic cart = await _api.add_to_cart(widget.id.toString());
                                if(cart['success'] == 1){
                                  setState(() {
                                    message = cart['message'];
                                  });
                                  Alert(
                                    context: context,
                                    type: AlertType.success,
                                    title: "عملية ناجحة",
                                    desc: "${message}",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "متابعة",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show();
                                }else{
                                  setState(() {
                                    message = 'حدث خطا';
                                  });
                                  Alert(
                                    context: context,
                                    type: AlertType.error,
                                    title: "خطأ",
                                    desc: "${message}",
                                    buttons: [
                                      DialogButton(
                                        child: Text(
                                          "متابعة",
                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        width: 120,
                                      )
                                    ],
                                  ).show();                                }
                            },
                            child: Center(
                              child: Text(' اضف الي السله', style: TextStyle(fontWeight: FontWeight.bold),)
                            ),
                          ),
                        ),
                        SizedBox(height: 25,),
                        SizedBox(height: 10,),
                        Text(widget.desc ,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),

                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
