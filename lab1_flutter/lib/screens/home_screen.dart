import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lab1_flutter/commons/displayDialog.dart';
import 'package:lab1_flutter/provider/crud_notifier.dart';
import 'package:lab1_flutter/provider/theme_notifier.dart';
import 'package:lab1_flutter/themes.dart';
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

  void addPassanger(BuildContext context, Map<String, String> inputData) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    if (inputData == null) return;
    provider.add(Passanger.fromJson(inputData));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    final themeProvider = Provider.of<ThemeNotifier>(context, listen: true);
    List<Passanger> passangers = provider.getPassangers;
    List<Widget> passangerWidgets = passangers
        .map((f) => PassangerWidget(
              key: Key(f.id.toString()),
              passanger: f,
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(widget.darkThemeEnabled
                ? Icons.wb_sunny
                : FontAwesomeIcons.moon),
            onPressed: themeProvider.changeTheme,
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: passangerWidgets,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          // backgroundColor: Colors.black,
          onPressed: () async {
            Map<String, String> inputData = await displayDialog(
                context: context, title: "Add a passanger", buttonText: "ADD");
            addPassanger(context, inputData);
          }),
    );
  }
}
