import 'package:bany/models/person.dart';
import 'package:bany/view/infoData.dart';
import 'package:bany/event/bloc_Event.dart';
import 'package:bany/view/listData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => BlocEven(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red,iconTheme: IconThemeData(color: Colors.black)),
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home': (context) => ListData(),

        },
      ),
    );
  }
}
