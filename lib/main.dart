import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/routes.dart';
import 'package:tech_media/view_model/theme_mode/theme_mode.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(create: (_)=> ChangeThemeMode(),
      child: Builder(builder: (BuildContext context){
        final themeChanger = Provider.of<ChangeThemeMode>(context);
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
              primarySwatch: AppColors.primaryMaterialColor,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                color: AppColors.whiteColor,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  fontFamily: AppFonts.sfProDisplayMedium,
                  color: AppColors.primaryTextTextColor,
                ),
              ),
              textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize: 40,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height: 1.6),
                displayMedium: TextStyle(fontSize: 32,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height: 1.6),
                displaySmall: TextStyle(fontSize: 28,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height: 1.9),
                headlineMedium: TextStyle(fontSize: 24,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height: 1.6),
                headlineSmall: TextStyle(fontSize: 20,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height: 1.6),
                titleLarge: TextStyle(fontSize: 17,fontFamily: AppFonts.sfProDisplayBold,color: AppColors.primaryTextTextColor,fontWeight: FontWeight.w500,height: 1.6),
                bodyLarge: TextStyle(fontSize: 17,fontFamily: AppFonts.sfProDisplayBold,color: AppColors.primaryTextTextColor,fontWeight: FontWeight.w700,height: 1.6),
                bodyMedium: TextStyle(fontSize: 14,fontFamily: AppFonts.sfProDisplayRegular,color: AppColors.primaryTextTextColor,height: 1.6),
                bodySmall: TextStyle(fontSize: 12,fontFamily: AppFonts.sfProDisplayBold,color: AppColors.primaryTextTextColor,height:2.26),
              )

          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
              appBarTheme: const AppBarTheme(

                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  fontFamily: AppFonts.sfProDisplayMedium,
                  color: AppColors.whiteColor,
                ),
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                modalBackgroundColor: Colors.black,
                backgroundColor: Colors.black54,
              ),

              textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize: 40,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.whiteColor,fontWeight: FontWeight.w500,height: 1.6),
                displayMedium: TextStyle(fontSize: 32,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.whiteColor,fontWeight: FontWeight.w500,height: 1.6),
                displaySmall: TextStyle(fontSize: 28,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.whiteColor,fontWeight: FontWeight.w500,height: 1.9),
                headlineMedium: TextStyle(fontSize: 24,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.whiteColor,fontWeight: FontWeight.w500,height: 1.6),
                headlineSmall: TextStyle(fontSize: 20,fontFamily: AppFonts.sfProDisplayMedium,color: AppColors.whiteColor,fontWeight: FontWeight.w500,height: 1.6),
                titleLarge: TextStyle(fontSize: 17,fontFamily: AppFonts.sfProDisplayBold,color: AppColors.whiteColor,fontWeight: FontWeight.w500,height: 1.6),
                bodyLarge: TextStyle(fontSize: 17,fontFamily: AppFonts.sfProDisplayBold,color: AppColors.whiteColor,fontWeight: FontWeight.w700,height: 1.6),
                bodyMedium: TextStyle(fontSize: 14,fontFamily: AppFonts.sfProDisplayRegular,color: AppColors.whiteColor,height: 1.6),
                bodySmall: TextStyle(fontSize: 12,fontFamily: AppFonts.sfProDisplayBold,color: AppColors.whiteColor,height:2.26),
              )
          ),
          themeMode:  themeChanger.themeMode,
          initialRoute: RouteName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
        );
      },)


    );
  }
}

