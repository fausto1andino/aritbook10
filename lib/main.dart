import 'package:aritbook10/src/common/Themes/data_theme.dart';
import 'package:aritbook10/src/core/Provider/main_provider.dart';
import 'package:aritbook10/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'src/pages/home_page.dart';
import 'src/widgets/themedetails.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) {
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MainProvider()),
          ],
          child: const MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Get an instance of MainProvider using a BuildContext reference

  @override
  Widget build(BuildContext context) {
    final mainProviderSave = Provider.of<MainProvider>(context, listen: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AritBook10',
       routes: {
      
        'detailsTheme': (_) => const ThemeDetailsScreen(),

      },
      theme: AppTheme.themeData(false).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        },
        
      )
      
      ),
      home: FutureBuilder(
          future: mainProviderSave.getPreferencesToken(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.hasError.toString()}"),
                  );
                }
            }

            return (snapshot.data != "")
                ? const MyHomePage(title: 'Ejericio 1')
                : const LoginPage();
          }),
    );
  }
}
