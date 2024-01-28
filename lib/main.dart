import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/authantication/landing_view/view/landing_view.dart';

void main() async {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(routes: <RouteBase>[
        GoRoute(
          path: "/",
          builder: (context, state) => const LandingView(),
        ),
      ]),
    );
  }
}
