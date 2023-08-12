import 'package:avatar_course2_7_note_provider/features/app/presentation/controller/home_controller.dart';
import 'package:avatar_course2_7_note_provider/features/app/presentation/view/add_note_view.dart';
import 'package:avatar_course2_7_note_provider/features/app/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/dependancy_injection.dart';
import 'features/app/presentation/view/note_details_view.dart';
import 'routes/routes.dart';
import 'features/splash/presentation/view/splash_screen.dart';

void main() async {
  initModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        routes: {
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.homeView: (context) => const HomeView(),
          Routes.addNoteView: (context) => const AddNoteView(),
          Routes.noteDetailsView: (context) => const NoteDetailsView(),
        },
      ),
    );
  }
}
