import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MatchBook extends StatefulWidget {
  const MatchBook({super.key,required this.book});
  final Map book;

  @override
  State<MatchBook> createState() => _MatchBookState();
}

class _MatchBookState extends State<MatchBook> {
  @override
  bool fullDescription = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del libro'),
        backgroundColor: Color.fromARGB(255, 71, 71, 71),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {
            final title = widget.book['volumeInfo']['title'].toString();
            final pages = widget.book['volumeInfo']['pageCount'].toString();
            Share.share('${title}, ${pages}');
         }),
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image(image: NetworkImage(widget.book['volumeInfo']['imageLinks'] == null? "https://marketplace.canva.com/EADapBYldI0/1/0/251w/canva-black-%26-white-minimalist-modern-graphic-design-book-cover-EWhNzFlbFuk.jpg": widget.book['volumeInfo']['imageLinks']['thumbnail'])),
            ),
          ),
          SizedBox(height: 5,),
          Text(widget.book['volumeInfo']['title'], style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30, ),  textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Text(widget.book['volumeInfo']['publishedDate'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15), textAlign: TextAlign.left,),
                  Text('Pags. '+widget.book['volumeInfo']['pageCount'].toString(), style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: GestureDetector(
              child: Text(widget.book['volumeInfo']['description'] == null? 'Descripción no disponible': fullDescription == true?  widget.book['volumeInfo']['description'].toString().substring(0, 256)+'...': widget.book['volumeInfo']['description'].toString().substring(0, 128)+'...', style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
              onTap: () {
                this.fullDescription = !this.fullDescription;
                print(this.fullDescription);
                setState(() {});
              },
            ),
          )
          
        ],
      ),
    );
  }
}