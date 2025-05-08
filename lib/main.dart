import 'package:flutter/material.dart';
import 'package:future_home_app/pages/details_page.dart';
import 'package:future_home_app/pages/form_page.dart';
import 'package:future_home_app/pages/home_page.dart';
import 'package:future_home_app/routes.dart';
import 'package:future_home_app/providers/residence_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ResidenceProvider()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Future Home",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
      ),
      routes: {
        Routes.HOME: (context) => const HomePage(),
        Routes.FORM: (context) => const FormPage(),
        Routes.DETAILS: (context) => const DetailsPage(),
      },
    );
  }
}
