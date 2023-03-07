import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/features/stopwatch/repository/stopwatch_repository.dart';
import 'config/app_provider.dart';
import 'features/home/pages/home.dart';
import 'features/home/pages/menu.dart';

import './config/core_theme.dart' as theme;

import 'features/onboarding/pages/onboarding.dart';
import 'features/stopwatch/bloc/stopwatch_bloc.dart';
import 'features/stopwatch/pages/stopwatch_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
        child: Consumer<AppProvider>(
            builder: (context, value, _) => MaterialChild(provider: value)));
  }
}

/// This is an alternative approach to handle multiple state management: [Provider] + [Bloc]
/// A new MaterialChild class will handle to [Provider] initialization as well as the [Shared Preferences]
/// [Theme] selection is managed by [Shared Preferences]
class MaterialChild extends StatefulWidget {
  final AppProvider provider;
  const MaterialChild({Key? key, required this.provider}) : super(key: key);

  @override
  State<MaterialChild> createState() => _MaterialChildState();
}

class _MaterialChildState extends State<MaterialChild> {
  /// Using GoRouter Package to handle the [Navigation] for the whole app
  /// This approach helps when configuring routes for Flutter Web as well
  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
          path: '/onboarding', builder: (context, state) => const Onboarding()),
      GoRoute(path: '/menu', builder: (context, state) => const Menu()),
      GoRoute(
          path: '/homestopwatch',
          builder: (context, state) => const HomeStopWatch()),
    ],
  );

  void initAppTheme() {
    final appProviders = AppProvider.state(context);
    appProviders.init();
  }

  @override
  void initState() {
    initAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// The [Bloc] wraps the main Material App
    return BlocProvider(
      create: (context) =>
          StopwatchBloc(stopWatchRepository: StopwatchRepository()),
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme.themeLight,
          darkTheme: theme.themeDark,
          themeMode: widget.provider.themeMode,

          /// Using [Responsive] package to handle the UI resize for any device
          builder: (context, child) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, child!),
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(480, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET)
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
          routerConfig: _router),
    );
  }
}
