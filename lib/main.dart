import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/FBOScreen/FBO_Tenant_Schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Tenant_schedule_tab.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/tabbar_screen/Transient_schedule_tab_Pilot.dart';
import 'package:provider/provider.dart';

import 'Screens/Pilot_And_Transient_Screen/Pilot_Tenant_Schedule_tab.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/tabbar_screen/Transient_schedule_tab.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: TenantScheduleProvider()),
          ChangeNotifierProvider.value(value: TransientScheduleProvider()),
          ChangeNotifierProvider.value(value: TransientScheduleProvider2()),
          ChangeNotifierProvider.value(value: FBO_TenantScheduleProvider()),
          ChangeNotifierProvider.value(value: Pilot_TenantScheduleProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Stackit',
          theme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.blue.shade500),
            // colorScheme: ColorScheme(
            //   // brightness: Brightness.light,
            //   primary: Colors.blue.shade300,
//               onPrimary: Colors.black,
// // Colors that are not relevant to AppBar in LIGHT mode:
//               primaryVariant: Colors.blue.shade300,
//               secondary: Colors.blue.shade300,
//               secondaryVariant: Colors.blue.shade300,
//               onSecondary: Colors.blue.shade300,
//               background: Colors.blue.shade300,
//               onBackground: Colors.blue.shade300,
//               surface: Colors.blue.shade300,
//               onSurface: Colors.blue.shade300,
//               error: Colors.blue.shade300,
//               onError: Colors.blue.shade300,
//             ),
            // accentColor: Colors.blue,
          ),
          home: SplashScreen(),
        ));
  }
}

// colorScheme: ColorScheme(
// brightness: Brightness.light,
// primary: Colors.yellow,
// onPrimary: Colors.black,
// // Colors that are not relevant to AppBar in LIGHT mode:
// primaryVariant: Colors.grey,
// secondary: Colors.grey,
// secondaryVariant: Colors.grey,
// onSecondary: Colors.grey,
// background: Colors.grey,
// onBackground: Colors.grey,
// surface: Colors.grey,
// onSurface: Colors.grey,
// error: Colors.grey,
// onError: Colors.grey,
// ),
