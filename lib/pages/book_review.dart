import 'dart:async';
import 'dart:io';

import 'package:book_shop/Wrapper.dart';
import 'package:book_shop/pages/mybook.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';


class BookViewer extends StatefulWidget {
  final dynamic book_url;
  const BookViewer({ Key? key, required this.book_url}) : super(key: key);
  @override
  _BookViewertate createState() => _BookViewertate();
}

class _BookViewertate extends State<BookViewer> {
  String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  String corruptedPathPDF = "";

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await   Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Wrapper()),
        );
        return shouldPop!;
      },
      child: Scaffold(
          body: Center(child: Builder(
            builder: (BuildContext context) {
              return  PDF(
                defaultPage: 5,
                swipeHorizontal: true,
              ).cachedFromUrl(widget.book_url)
              ;
            },
          )),

      ),
    );
  }
}

