import 'package:flutter/material.dart';
import 'package:tka_demo/page/components/drawer.dart';
import 'package:tka_demo/programability/rest/rest_manager.dart';
import 'package:tka_demo/page/rest_test/rest_test_data.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';
  static const String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  Future<RESTTestData> futureRESTTestData;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    futureRESTTestData = RestManager.fetch(RESTTestData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FutureBuilder<RESTTestData>(
              future: futureRESTTestData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("Data from REST: " + snapshot.data.email);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
