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
  int flutter = 0,
      rn = 0,
      flutterf = 0,
      rnf = 0,
      difference = 0,
      differencef = 0;
  Timer t;
  @override
  void initState() {
    super.initState();
    getStarts();
  }

  Future getStarts() async {
    flutter = await getStarFromGithubRepo("flutter/flutter");
    rn = await getStarFromGithubRepo("facebook/react-native");
    flutterf = await getForksFromGithubRepo("flutter/flutter");
    rnf = await getForksFromGithubRepo("facebook/react-native");
    difference = rn - flutter;
    differencef = rnf - flutterf;
    setState(() {});
  }

  Future<int> getStarFromGithubRepo(String repoName) async {
    var resp = await get(
        "https://api.github.com/repos/$repoName?client_id=8f268ae1ea31c6b6309d&client_secret=7dd7decea342b9e7592ff0dd9995a53ff1766f4e");
    return json.decode(resp.body)["stargazers_count"];
  }

  Future<int> getForksFromGithubRepo(String repoName) async {
    var resp = await get(
        "https://api.github.com/repos/$repoName?client_id=8f268ae1ea31c6b6309d&client_secret=7dd7decea342b9e7592ff0dd9995a53ff1766f4e");
    return json.decode(resp.body)["forks_count"];
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
                "Flutter vs react native star",
                style: Theme.of(context).textTheme.title,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "$flutter Vs",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "$rn",
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Text(
                    "Difference:",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    "$difference",
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
              Text(
                "Flutter vs react native forks",
                style: Theme.of(context).textTheme.title,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "$flutterf Vs",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "$rnf",
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Text(
                    "Difference:",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    "$differencef",
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
