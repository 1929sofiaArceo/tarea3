import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './match_book.dart';
import 'myprovider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final bookTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Libreria free to play'),
        backgroundColor: Color.fromARGB(255, 71, 71, 71),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              controller: bookTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingresa título',
                suffixIcon: Align(
                  widthFactor: 1.0,
                  heightFactor: 1.0,
                  child: IconButton(onPressed: () async => {
                    await context.read<MyProvider>().search(this.bookTitle.value.text),
                  },
                  icon: Icon(Icons.search),),
                ),
              ),
            ),
          ),
          context.watch<MyProvider>().isLoading ? CircularProgressIndicator(value: 0.8,) : SizedBox(),
          context.watch<MyProvider>().result.length == 0 ? SizedBox(height: 250,): SizedBox(),
          context.watch<MyProvider>().result.length == 0 ? Text("Ingrese palabra para buscar el título") : SizedBox(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 30, //separacion <->
              mainAxisSpacing: 10, // separacion arriba a abajo
              shrinkWrap: true,
              children: List<Widget>.generate(
                (context.watch<MyProvider>().result['totalItems'] != null? context.watch<MyProvider>().result['items'].length: 0),
                (index) => 
                GestureDetector(
                  onTap: () {
                    var tapped_book = context.read<MyProvider>().result['items'][index];
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MatchBook(book: tapped_book)));
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(context.read<MyProvider>().result['items'][index]['volumeInfo']['imageLinks'] == null? "https://marketplace.canva.com/EADapBYldI0/1/0/251w/canva-black-%26-white-minimalist-modern-graphic-design-book-cover-EWhNzFlbFuk.jpg": context.read<MyProvider>().result['items'][index]['volumeInfo']['imageLinks']['thumbnail']),
                          fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "${context.read<MyProvider>().result['items'][index]['volumeInfo']['title']}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                              ),
                            ),
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
