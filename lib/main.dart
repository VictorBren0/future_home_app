import 'package:flutter/material.dart';
import 'package:future_home_app/pages/details_page.dart';
import 'package:future_home_app/pages/form_page.dart';
import 'package:future_home_app/pages/home_page.dart';
import 'package:future_home_app/pages/login_page.dart';
import 'package:future_home_app/pages/register_page.dart';
import 'package:future_home_app/providers/auth_provider.dart';
import 'package:future_home_app/routes.dart';
import 'package:future_home_app/providers/residence_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ResidenceProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => AuthProvider()),
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
          seedColor: const Color.fromARGB(94, 33, 91, 255),
        ),
      ),
      initialRoute: AuthProvider().isAuthenticated ? Routes.HOME : Routes.LOGIN,
      routes: {
        Routes.LOGIN: (context) => const LoginPage(),
        Routes.REGISTER: (context) => const RegisterPage(),
        Routes.HOME: (context) => const HomePage(),
        Routes.FORM: (context) => const FormPage(),
        Routes.DETAILS: (context) => const DetailsPage(),
      },
    );
  }
}
