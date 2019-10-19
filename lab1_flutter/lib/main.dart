import 'package:flutter/material.dart';
import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/passanger_widget.dart';
import 'package:lab1_flutter/provider/crud_notifier.dart';
import 'package:lab1_flutter/repository.dart';
import 'package:provider/provider.dart';
import 'commons/displayDialog.dart';
import 'controller.dart';

void main() {
  Repository repository = new Repository();
  Controller controller = new Controller(repository: repository);
  runApp(
    ChangeNotifierProvider(
      builder: (context) =>
          CrudNotifier(controller: controller, repository: repository),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({this.title, Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int biggestId = 0;
  final TextEditingController _textFieldController = TextEditingController();

  void addPassanger(BuildContext context, Map<String, String> inputData) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    provider.add(Passanger(name: inputData["name"]));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
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
      ),
      body: Container(
          child: Column(
        children: passangerWidgets,
      )),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
          onPressed: () async {
            Map<String, String> inputData = await displayDialog(
                context: context, title: "Add a passanger", buttonText: "ADD");
            addPassanger(context, inputData);
          }),
    );
  }
}
