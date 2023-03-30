import 'package:final_project/pages/add_edit_book.dart';
import 'package:flutter/material.dart';
import '../Models/book.dart';
import 'add_book.dart';

class BookList extends StatefulWidget {
  late List<Book> books;
  BookList({Key? key, required List<Book> booksToGenerate}) : super(key: key) {
    books = booksToGenerate;
  }

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.blueGrey,
              Colors.yellow,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
            itemCount: widget.books.length,
            itemExtent: 150,
            itemBuilder: _listItemBuilder),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEditBook()));
        },
        child: const Icon(Icons.add)
      ),
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    Book book = widget.books[index];
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          size: 50,
        ),
      ),
      onDismissed: (direction) {
        Book book = widget.books[index];
        setState(() {
          if (direction == DismissDirection.startToEnd) {
            widget.books.removeAt(index);
          }
        });
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 14, 60, 82),
            content: const Text(
              "Are You Sure You Want To Delete This Item ??",
              style: TextStyle(
                color: Colors.white,
                  fontFamily: "Times New Roman",
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                        fontFamily: "Times New Roman",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),),
              TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  icon: const Icon(Icons.cancel_rounded, color: Colors.blue,),
                  label: const Text("Cancel", 
                  style: TextStyle(
                      color: Colors.blue,
                        fontFamily: "Times New Roman",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),),
            ],
          ),
        );
      },
      child: _getItemCard(context, widget.books[index]),
    );
  }

  Widget _getItemCard(BuildContext context, Book book) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _bookDetails(context, book),
        child: Card(
          color: const Color.fromARGB(255, 14, 60, 82),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.transparent, width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(book.bookCover),
                  width: 75,
                  height: 75,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Title: ${book.title}",
                        style: const TextStyle(
                            color: Colors.amber,
                            fontFamily: "Times New Roman",
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Price: \$${book.price}",
                        style: const TextStyle(
                            color: Colors.amber,
                            fontFamily: "Times New Roman",
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function To Show Book Details When Long Pressed
  _bookDetails(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 14, 60, 82),
        title: const Text(
          "Book Details",
          style: TextStyle(
              color: Colors.amber,
              fontFamily: "Times New Roman",
              fontSize: 23,
              fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(image: AssetImage(book.bookCover)),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Title: ${book.title}",
                style: const TextStyle(
                    color: Colors.amber,
                    fontFamily: "Times New Roman",
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "Price: \$${book.price}",
              style: const TextStyle(
                  color: Colors.amber,
                  fontFamily: "Times New Roman",
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Borrowed: ${book.isBorrowed}",
              style: const TextStyle(
                  color: Colors.amber,
                  fontFamily: "Times New Roman",
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(
              Icons.build,
              color: Colors.amber,
            ),
            label: const Text(
              "Edit",
              style: TextStyle(
                  color: Colors.amber,
                  fontFamily: "Times New Roman",
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: const Icon(
              Icons.cancel_rounded,
              color: Colors.amber,
            ),
            label: const Text(
              "Cancel",
              style: TextStyle(
                  color: Colors.amber,
                  fontFamily: "Times New Roman",
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
  
  
}
