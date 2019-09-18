import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ComparisionScreen(),
    );
  }
}

class ComparisionScreen extends StatefulWidget {
  @override
  _ComparisionScreenState createState() => _ComparisionScreenState();
}

class _ComparisionScreenState extends State<ComparisionScreen> {
  int flutter = 0, rn = 0, difference = 0;
  Timer t;
  @override
  void initState() {
    super.initState();
    getStarts();
  }

  Future getStarts() async {
    flutter = await getStarFromGithubRepo("flutter/flutter");
    print(flutter);
    rn = await getStarFromGithubRepo("facebook/react-native");
    difference = rn - flutter;
    setState(() {});
  }

  Future<int> getStarFromGithubRepo(String repoName) async {
    var resp = await get(
        "https://api.github.com/repos/$repoName?client_id=8f268ae1ea31c6b6309d&client_secret=7dd7decea342b9e7592ff0dd9995a53ff1766f4e");
    return json.decode(resp.body)["stargazers_count"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Comparision"),
      ),
      body: GestureDetector(
        onTap: getStarts,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Flutter star",
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                "$flutter",
                style: Theme.of(context).textTheme.display1,
              ),
              SizedBox(height: 20),
              Text(
                "React Native star",
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                "$rn",
                style: Theme.of(context).textTheme.display1,
              ),
              SizedBox(height: 20),
              Text(
                "Difference",
                style: Theme.of(context).textTheme.title,
              ),
              Text(
                "$difference",
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
