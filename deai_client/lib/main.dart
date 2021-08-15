import 'package:deai_client/CompositionRoot.dart';
import 'package:deai_client/start.dart';
import 'package:deai_client/router.dart';
import 'package:deai_client/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

import 'package:google_fonts/google_fonts.dart';
import 'controllers/MenuController.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
   
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Decentralized AI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      home: Start(),
    );
  }
}

