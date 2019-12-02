import 'package:flutter/material.dart';
import 'package:lab1_flutter/provider/crud_notifier.dart';
import 'package:lab1_flutter/provider/theme_notifier.dart';
import 'package:lab1_flutter/repos/local_db_repository.dart';
import 'package:lab1_flutter/repos/repository.dart';
import 'package:lab1_flutter/repos/server_repository.dart';
import 'package:lab1_flutter/screens/home_screen.dart';
import 'package:lab1_flutter/themes.dart';
import 'package:provider/provider.dart';
import 'controller.dart';
import 'database_creator.dart';

void main() async {
  await DatabaseCreator().initDatabase();
  Repository repository = new ServerRepository();
  Controller controller = new Controller(repository: repository);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CrudNotifier>.value(
        value: CrudNotifier(
          controller: controller,
          repository: repository,
          isOnline: true,
        ),
      ),
      ChangeNotifierProvider<ThemeNotifier>.value(value: ThemeNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeNotifier>(context, listen: true);
    return MaterialApp(
      title: 'Passanger CRUD',
      theme: provider.darkThemeEnabled ? darkTheme : lightTheme,
      home: MyHomePage(
          darkThemeEnabled: provider.darkThemeEnabled, title: 'Passanger CRUD'),
    );
  }
}
