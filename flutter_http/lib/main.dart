import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Post> fetchPost() async {
  String uri = 'http://192.168.1.105:8000/api/details';
  final response =
      await http.post(Uri.encodeFull(uri),headers: {"Accept": "application/json","Content-Type": "application/x-www-form-urlencoded", "Authorization":"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjUxYjdiZjM1NDQyMThkZTk1MTVlOGY0MzYyOTY4ZmUzZWVmN2QwMzlhZGJjZmFmYWM0MDc5NDc5NmJjMWM5ZDk5NjNlYjZlNDg2N2QwNTdiIn0.eyJhdWQiOiIxIiwianRpIjoiNTFiN2JmMzU0NDIxOGRlOTUxNWU4ZjQzNjI5NjhmZTNlZWY3ZDAzOWFkYmNmYWZhYzQwNzk0Nzk2YmMxYzlkOTk2M2ViNmU0ODY3ZDA1N2IiLCJpYXQiOjE1NDk1MzYyNTQsIm5iZiI6MTU0OTUzNjI1NCwiZXhwIjoxNTgxMDcyMjU0LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.afsEtLV1V1tIQigbgXMTGuV0QO66dlNpZKOQZWI94YCjNIQcuXBQeEdX6rzHdoj69LMwAczk6YU5R_RZxpNpmq7dxPwji30r1hbgx1sXcysdf6tqB9SHyXQdbGJWwDtV_1gbnytcJkuOpM3mjzH1-PbdkCngVvxPecUAgP-wJFJ7SoBBmkBQPN-gNdlX7KLVDkrVQzYfu8S-WTxPKzAGxuw1Q3rEtZvSSRlUKnao1IruXXCB1evB0TyURwLXOvqujIpx9RtKlll6ZROsWMJOT9gd_Nw_c2pnQIggXsUUfXWT69qOnmmnVAuaFBTWD6v-aJYCRmTA7I_UNKx57J0ZGWdpI43BpFPRdvKgtdH-QHMoZQr_zSoLr5V6xaNxh13RiwqrYV7sy8d8rc92mhyzaudRgIywsRKMaKYHc8WRRcoN5CqE14tq1EXhI3wyL3lawM66kbCUkMrxLXNT4kEAia6feupHUmfHRyLlUrLs4BpFp3iwlNZyndk4wdm4sAuN1TwmgTdH2yKomXgSQBUcP3SNB-QD2pqe4jnvQLHl1TXBvD_TCURX7hM4xj7stavok2HPDOIF4njN7awzvbgCsWdSnSGjuY0O1ACXHuWTRek_2JkNGAdGHBRfi_qxtwPHT8WrNd_IZC8LPHJC0CjawFECc4V-WNpkwzyfpmC-xfY"} );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      print(json.decode(response.body));
      return Post.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      print(json.decode(response.body));
      throw Exception('Failed to load post');
    }
}
final JsonDecoder _decoder = new JsonDecoder();

Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

void main() => runApp(MyApp(post:fetchPost()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<Post> post;
  MyApp({Key key, this.post}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: MyHomePage(title: 'Flutter Demo Home Page'),
  //   );
  // }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  String url = 'https://randomuser.me/api/';
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: Text(widget.title),
        title: Text("App title"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
