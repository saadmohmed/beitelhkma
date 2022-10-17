import 'dart:io';
import 'package:book_shop/Constant.dart';
import 'package:book_shop/models/Book.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiProvider{


  Future register(String name ,String email, String password , String phone ,String country ,String birth_day  ,String newsteller ,) async {
    final http.Response response = await http.post(
      Uri.parse('${REGISTER_API}'),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },
      body: {
        'name': name,

        'email': email,
        'password': password,
        'password_confirmation': password,

        'phone': phone,
        'country': country,
        'birth_day': birth_day,
        'newsteller': newsteller,

      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future login(String email, String password) async {
    final http.Response response = await http.post(
      Uri.parse('${LOGIN_API}'),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future add_to_cart(String book_id) async {
    final storage = new FlutterSecureStorage();
    final api_token = await storage.read(
      key: 'api_token',
    );
    final http.Response response = await http.post(
      Uri.parse('${ADD_TO_CART}?api_token=$api_token'),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },
      body: {
        'book_id': book_id,
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }
  Future<List<Book>> mybooks( ) async{

    final storage = new FlutterSecureStorage();
    final api_token = await storage.read(
      key: 'api_token',
    );
    List<Book> books = [];
    final http.Response response = await http.get(
      Uri.parse(MY_BOOKS+"?api_token="+api_token!),
      headers:<String , String>{
        'Accept': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },

    );
    if (response.statusCode == 200) {

      dynamic body = json.decode(response.body);
      body["data"].forEach((elemnt){
        books.add(new Book(
            id: elemnt['id'],
            title: elemnt['title'] ,
            price: elemnt["price"],
            image: elemnt['preview'],
            discount: elemnt["price"],
            data_file: elemnt["file_data"],
            content: elemnt["content"]

        ));

      });


    }
    return books;
  }
  Future<List<Book>> getCart( ) async{

    final storage = new FlutterSecureStorage();
    final api_token = await storage.read(
      key: 'api_token',
    );
    List<Book> books = [];
    final http.Response response = await http.get(
      Uri.parse(CART+"?api_token="+api_token!),
      headers:<String , String>{
        'Accept': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },

    );
    if (response.statusCode == 200) {
      dynamic body = json.decode(response.body);
      body["data"].forEach((elemnt){
        elemnt = elemnt['book'];
        books.add(new Book(
            id: elemnt['id'],
            title: elemnt['title'] ,
            price: elemnt["price"],
            image: elemnt['preview'],
            discount: elemnt["price"],
            data_file: elemnt["file_data"],
            content: elemnt["content"]

        ));

      });


    }
    return books;
  }
  Future add_order() async {
    final storage = new FlutterSecureStorage();
    final api_token = await storage.read(
      key: 'api_token',
    );
    final http.Response response = await http.post(
      Uri.parse('${ADD_ORDER}?api_token='+api_token!),
      headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },
      body: {
        'make_order': "true",
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }

  Future<List<Book>> getBooks(dynamic type  ,dynamic limit ) async{

    final storage = new FlutterSecureStorage();
    final api_token = await storage.read(
      key: 'api_token',
    );
    List<Book> books = [];
    final http.Response response = await http.get(
      Uri.parse(BOOKS+"?api_token="+api_token!),
      headers:<String , String>{
        'Accept': 'application/json; charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
      },

    );
    if (response.statusCode == 200) {


      dynamic body = json.decode(response.body);
        body["data"].forEach((elemnt){
          books.add(new Book(
              id: elemnt['id'],
              title: elemnt['title'] ,
              price: elemnt["price"],
            image: elemnt['preview'],
            discount: elemnt["price"],
              data_file: elemnt["file_data"],
              content: elemnt["content"]

          ));

          });


    }
    return books;
  }

  Future<bool> user() async {
    final storage = new FlutterSecureStorage();
    final api_token = await storage.read(
      key: 'api_token',
    );
    try{
      final http.Response response = await http.get(
        Uri.parse(USER_API + '?api_token=' + api_token!),
        headers: <String, String>{
          'Accept': 'application/json; charset=UTF-8',
          'Access-Control-Allow-Origin': '*'
        },
      );
      if (response.statusCode == 200) {
        return true;
      }
    }catch(e){
      return false;

    }

    return false;
  }

  Future getName() async {
    final storage = new FlutterSecureStorage();
    final name = await storage.read(
      key: 'name',
    );

    return name;
  }
  Future logout() async {
    final storage = new FlutterSecureStorage();
    final name = await storage.deleteAll();

    return name;
  }
}