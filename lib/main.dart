import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fuse_wallet/ui/base/fw_base_state.dart';
import 'package:fuse_wallet/ui/base/fw_base_widget.dart';
import 'package:fuse_wallet/utils/fw_resources.dart';
import 'package:localization/localization.dart';

import 'model/fw_main_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FwApp());
}

class FwApp extends StatelessWidget {
  const FwApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xff131621),
      statusBarColor:  Color(0xff131621),
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness:  Brightness.light,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: resources.navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate
      ],

      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),
      home: const FwHomePage(),
    );
  }
}

class FwHomePage extends FwBaseWidget {
  const FwHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<FwHomePage> createState() => _FwHomePageState();
}

class _FwHomePageState extends FwBaseState<FwHomePage> {

  @override
  void initState() {
    super.initState();
    applicationModel.setState(this) ;
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      body: applicationModel.currentPage ,
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
