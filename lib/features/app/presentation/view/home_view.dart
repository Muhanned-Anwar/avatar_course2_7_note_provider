import 'package:avatar_course2_7_note_provider/core/constants.dart';
import 'package:avatar_course2_7_note_provider/core/resources/manager_colors.dart';
import 'package:avatar_course2_7_note_provider/core/resources/manager_font_sizes.dart';
import 'package:avatar_course2_7_note_provider/core/resources/manager_height.dart';
import 'package:avatar_course2_7_note_provider/core/resources/manager_icon_sizes.dart';
import 'package:avatar_course2_7_note_provider/core/resources/manager_raduis.dart';
import 'package:avatar_course2_7_note_provider/core/resources/manager_strings.dart';
import 'package:avatar_course2_7_note_provider/core/resources/manager_width.dart';
import 'package:avatar_course2_7_note_provider/features/app/presentation/controller/home_controller.dart';
import 'package:avatar_course2_7_note_provider/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeController>(context, listen: false).read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ManagerColors.transparent,
        elevation: 0,
        title: Text(
          ManagerStrings.appName,
          style: TextStyle(
            fontSize: ManagerFontSizes.s20,
            color: ManagerColors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addNoteView);
        },
        backgroundColor: ManagerColors.secondaryColor,
        child: Icon(
          Icons.add,
          color: ManagerColors.white,
          size: ManagerIconSizes.s26,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: ManagerHeight.h14,
          horizontal: ManagerWidth.w14,
        ),
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ManagerColors.primaryColor,
              ManagerColors.secondaryColor,
            ],
          ),
        ),
        child: Consumer<HomeController>(
          builder: (context, controller, child) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: controller.notes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.noteDetailsView,
                        arguments: {
                          Constants.databaseNotesIdColumnName:
                              controller.notes[index].id,
                        });
                  },
                  child: Card(
                    color: ManagerColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        ManagerRadius.r12,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w8,
                            vertical: ManagerHeight.h14,
                          ),
                          child: Text(
                            controller.notes[index].content,
                            style: TextStyle(
                              color: ManagerColors.white,
                              fontSize: ManagerFontSizes.s16,
                            ),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            onPressed: () {
                              controller.delete(
                                  controller.notes[index].id, context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: ManagerColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
