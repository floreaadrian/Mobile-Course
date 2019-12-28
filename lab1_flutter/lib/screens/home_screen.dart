import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lab1_flutter/commons/displayDialog.dart';
import 'package:lab1_flutter/provider/crud_notifier.dart';
import 'package:lab1_flutter/provider/theme_notifier.dart';
import 'package:lab1_flutter/widgets/passanger_widget.dart';
import 'package:provider/provider.dart';

import '../passanger.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final bool darkThemeEnabled;

  const MyHomePage({this.title, Key key, this.darkThemeEnabled})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int biggestId = 0;

  var subscription;

  @override
  void initState() {
    final provider = Provider.of<CrudNotifier>(context, listen: false);
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        provider.changeInternetStatus(false);
      } else {
        provider.changeInternetStatus(true);
      }
    });
  }

  void addPassanger(BuildContext context, Map<String, dynamic> inputData) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    if (inputData == null) return;
    if (inputData["name"] == '' && inputData["email"] == '') return;
    provider.add(Passanger.fromJson(inputData));
  }

  Widget passangersWidget() {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    return FutureBuilder(
        future: provider.getPassangers(),
        builder: (context, passangersSnap) {
          if (passangersSnap.connectionState == ConnectionState.done) {
            if (passangersSnap.data == null) return Container();
            return ListView.builder(
              itemCount: passangersSnap.data.length,
              itemBuilder: (context, index) {
                return PassangerWidget(
                  key: Key(passangersSnap.data[index].id.toString()),
                  passanger: passangersSnap.data[index],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.wb_sunny),
                  Text('Change the theme'),
                  Icon(FontAwesomeIcons.moon),
                ],
              )),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.wb_sunny),
                  Text('Light theme'),
                  Icon(Icons.wb_sunny),
                ],
              ),
              onTap: () => themeProvider.changeTheme(false),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(FontAwesomeIcons.moon),
                  Text('Dark theme'),
                  Icon(FontAwesomeIcons.moon),
                ],
              ),
              onTap: () => themeProvider.changeTheme(true),
            ),
          ],
        ),
      ),
      body: Container(child: passangersWidget()),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          // backgroundColor: Colors.black,
          onPressed: () async {
            Map<String, dynamic> inputData = await displayDialog(
                context: context, title: "Add a passanger", buttonText: "ADD");
            addPassanger(context, inputData);
          }),
    );
  }

  @override
  dispose() {
    super.dispose();

    subscription.cancel();
  }
}
