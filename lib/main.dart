import 'dart:io';

import 'package:elevatormaintance/routes/route_generator.dart';
import 'package:elevatormaintance/screen/admin/controllers/MenuController.dart';
import 'package:elevatormaintance/screen/auth/auth_view_model.dart';
import 'package:elevatormaintance/view_model/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'config/environment.config.dart';
import 'config/hive_config.dart';
import 'config/preference.config.dart';
import 'constants/app_color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await EnvironmentConfig().init();
  await PreferenceUtils.init();
  await Hive.initFlutter();
  await HiveUtils.init();
  ByteData data =
      await PlatformAssetBundle().load('assets/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: Center(
            child: Container(
                height: 70,
                width: 70,
                child: Lottie.asset(
                    'assets/anim/114099-loading-animator-flutter.json'))),
      ),
      overlayOpacity: 0.8,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => CommonViewModel(),
          ),
          ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => MenuController(),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: MaterialApp(
            localizationsDelegates: const [
              FormBuilderLocalizations.delegate,
            ],
            title: 'Elevator App',
            theme: ThemeData(
                scaffoldBackgroundColor: white,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: kPrimaryColor,
                ),
                appBarTheme: const AppBarTheme(
                  color: kPrimaryColor,
                  foregroundColor: kPrimaryColor,
                  centerTitle: true,
                  iconTheme: IconThemeData(color: black),
                  elevation: 0,
                ),
                fontFamily: "Muli",
                    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: Colors.black),),
                // textTheme: const TextTheme(
                //     bodyText1: TextStyle(color: black),
                //     bodyText2: TextStyle(color: black))),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: RouteGenerator.generateRoute,
          ),
        ),
      ),
    );
  }
}
