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

      darkTheme: ThemeData.dark(), // standard dark theme
      themeMode: ThemeMode.system,
      theme: ThemeData(
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

class _FwHomePageState extends FwBaseState<FwHomePage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    applicationModel.setState(this) ;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    applicationModel.setState(null) ;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    applicationModel.didChangeAppLifecycleState(state);

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
