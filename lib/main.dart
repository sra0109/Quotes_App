import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatelessWidget {
  @override
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('QUOTES'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
            child: TextField(
              controller: usercontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
                hintText: 'User Name',
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: passcontroller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Password',
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton.icon(
            onPressed: () {
              if (usercontroller.text == "Roopa" &&
                  passcontroller.text == "Roopa") {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Quotes()));
              } else {
                Fluttertoast.showToast(
                  msg: 'Invalid Username or Password',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.yellow,
                );
              }
            },
            icon: Icon(Icons.account_circle_rounded),
            label: Text('Login'),
          )
        ],
      ),
    );
  }
}

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  List<Quote> quotes = [
    Quote(
        author: 'Thomas Mann',
        text:
            '"A writer is someone for whom writing is more difficult than it is for other people"'),
    Quote(
        author: 'Zig Ziglar',
        text:
            '"Your attitude, not your aptitude, will determine your altitude"'),
    Quote(
        author: 'Napolean Hill',
        text: 'If you cannot do great things, do small things in a great way')
  ];
  String result = ' ';
  TextEditingController nameController =
      TextEditingController(); //to access the text input
  TextEditingController authController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
            ),
          )
        ],
        title: Text('QUOTES'),
        // centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              // children: quotes.map((i) {
              //   //map is used to iterate
              //   return Text('${i.author} - ${i.text}'); //returns a text widget
              // }).toList(),
              // children: quotes.map((i) => Text(i.author + '-' + i.text)).toList(),
              children: quotes
                  .map((quote) => QuoteCard(
                      quote: quote,
                      delete: () {
                        setState(() {
                          quotes.remove(quote);
                        });
                      }))
                  .toList(),
            ),
            SizedBox(height: 30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 200.0,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quote',
                        hintText: 'Add Quote',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100.0,
                    child: TextField(
                      controller: authController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Author',
                        hintText: 'Author',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      result = nameController.text; //quote
                      String auth = authController.text; //author name
                      // print(result);
                      quotes.add(Quote(author: auth, text: result));
                      // nameController.dispose();
                      nameController.clear(); // to clear the text in textField
                      authController.clear();
                    });
                  },
                  icon: Icon(Icons.add_circle),
                  color: Colors.teal,
                  iconSize: 60.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
