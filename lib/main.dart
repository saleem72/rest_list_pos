import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'dependancy_injection.dart' as di;
import 'helpers/app_theme/app_theme.dart';
import 'helpers/app_theme/app_theme_cubit/app_theme_cubit.dart';
import 'helpers/auth_manager/auth_cubit/auth_cubit.dart';
import 'helpers/constants.dart';
import 'helpers/dashboard_bloc/dashboard_bloc.dart';
import 'helpers/localization/locale_cubit/locale_cubit.dart';
import 'screens/core/home_screen/repository/dashboard_repository.dart';
import 'screens/core/home_screen/service/dashboard_service_impl.dart';
import 'screens/core/home_screen/service/dashboard_service_mock.dart';
import 'screens/landing_screen/landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencies();
  runApp(const MyApp());
  doWhenWindowReady(() {
    const initialSize = Size(800, 600);
    // appWindow.size = initialSize;
    // appWindow.
    appWindow.minSize = initialSize;
    appWindow.title = 'Restlist POS';
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit(safe: di.locator())),
        BlocProvider(create: (context) => AppThemeCubit(safe: di.locator())),
        BlocProvider(create: (context) => AuthCubit(safe: di.locator())),
        BlocProvider(
          create: (context) => DashboardBloc(
            repository: DashboardRepositoryImpl(
              service: Constants.isDebuging
                  ? DashboardServiceMock()
                  : DashboardServiceImpl(),
            ),
          ),
        ),
      ],
      child: const RestListApp(),
    );
  }
}

class RestListApp extends StatelessWidget {
  const RestListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restlist POS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en', ''),
      home: const RestlistPOSApp(),
    );
  }
}

class RestlistPOSApp extends StatelessWidget {
  const RestlistPOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WindowBorder(
        width: 1,
        color: Colors.grey.shade300,
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(
                    child: MoveWindow(),
                  ),
                  const WindowButtons()
                ],
              ),
            ),
            const Expanded(
              child: LandingScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: ButtonColors.mainColors,
        ),
        MaximizeWindowButton(),
        CloseWindowButton(),
      ],
    );
  }
}

class ButtonColors {
  ButtonColors._();

  static WindowButtonColors mainColors = WindowButtonColors();
}
