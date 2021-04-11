import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/themes/darkTheme.dart';
import 'src/themes/themeStyle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String appName = 'Pillar';

  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePref.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool themeChange = themeChangeProvider.darkTheme;

    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, Widget child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appName,
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          home: Scaffold(
            appBar: AppBar(
              title: Text('Pillar'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Switch(
                      value: themeChange,
                      activeTrackColor: Colors.white,
                      activeColor: Colors.black,
                      onChanged: (bool value) {
                        themeChangeProvider.darkTheme = value;
                        themeChange = themeChange ? false : true;
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
