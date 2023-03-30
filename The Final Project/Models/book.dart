import 'dart:math';

enum BookStatus {
  notSelected,
  available,
  outOfStock,
}

class Book {

  late int id;
  late String title;
  late double price;
  late bool isBorrowed;
  late String bookCover;
  late BookStatus bookStatus;

  static final List<Book> _books = [];

  Book();

  Book._({this.id = -1, this.title = "", this.price = 5, this.bookCover = "",this.isBorrowed = false}); 

  static List<Book> generateData (int bookCount) {
    
    for (int i = 1; i <= bookCount; i++) {

      double priceRandom = Random().nextDouble() * 100;
      priceRandom = double.parse((priceRandom).toStringAsFixed(2));
      _books.add(
        Book._(
          id: i,
          title: "Book $i",
          price: priceRandom,
          isBorrowed: (priceRandom % 2 == 0) ? true : false,
          bookCover: "images/bookcover.png"
        )
      );
    }

    return _books;
  }

  static Book getNew({String name = "", double price = 35}) {
    return Book._(id: _books.length+1, title: name, price: price, bookCover: "images/bookcover.png");
  }

}