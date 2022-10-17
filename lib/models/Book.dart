class Book {
dynamic id;

  dynamic title;

  dynamic image;

  dynamic price;
dynamic content;

  dynamic discount;
dynamic data_file;

  Book({this.id ,this.title,this.image,this.price,this.discount,this.data_file , this.content});

  factory Book.fromJson(Map<String , dynamic> json){
    return Book(
      id : json["id"],
      title:  json["name"],
      image:  json["image"],
      price:  json["price"],
      discount:  json["discount"],
      data_file:  json["file_data"],
      content:  json["content"],

    );
  }

}