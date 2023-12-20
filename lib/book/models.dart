// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
    Model model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String image;
    String? authors;
    String categories;
    int price;
    Description description;
    int noOfPages;
    int stock;
    int rating;
    int jumlahTerjual;

    Fields({
        required this.title,
        required this.image,
        required this.authors,
        required this.categories,
        required this.price,
        required this.description,
        required this.noOfPages,
        required this.stock,
        required this.rating,
        required this.jumlahTerjual,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        image: json["image"],
        authors: json["authors"],
        categories: json["categories"],
        price: json["price"],
        description: descriptionValues.map[json["description"]]!,
        noOfPages: json["no_of_pages"],
        stock: json["stock"],
        rating: json["rating"],
        jumlahTerjual: json["jumlah_terjual"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "authors": authors,
        "categories": categories,
        "price": price,
        "description": descriptionValues.reverse[description],
        "no_of_pages": noOfPages,
        "stock": stock,
        "rating": rating,
        "jumlah_terjual": jumlahTerjual,
    };
}

enum Description {
    A_BOOK
}

final descriptionValues = EnumValues({
    "a book": Description.A_BOOK
});

enum Model {
    BOOK_BOOK
}

final modelValues = EnumValues({
    "book.book": Model.BOOK_BOOK
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}