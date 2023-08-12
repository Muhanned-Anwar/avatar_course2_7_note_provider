import 'package:avatar_course2_7_note_provider/core/storage/local/database/model/note.dart';
import 'package:avatar_course2_7_note_provider/core/widgets/helpers.dart';
import 'package:avatar_course2_7_note_provider/features/app/presentation/controller/home_controller.dart';
import 'package:avatar_course2_7_note_provider/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_sizes.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../../core/widgets/base_button.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({Key? key}) : super(key: key);

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> with Helpers {
  late TextEditingController _contentTextEditingController;
  late TextEditingController _titleTextEditingController;

  @override
  void initState() {
    super.initState();
    _contentTextEditingController = TextEditingController();
    _titleTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _contentTextEditingController.dispose();
    _titleTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ManagerColors.transparent,
        elevation: 0,
        title: Text(
          ManagerStrings.addNoteView,
          style: TextStyle(
            fontSize: ManagerFontSizes.s20,
            color: ManagerColors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
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
            return Container(
              margin: const EdgeInsetsDirectional.only(top: ManagerHeight.h100),
              child: Column(
                children: [
                  TextField(
                    controller: _titleTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Add Title Note',
                      hintStyle: TextStyle(
                        fontSize: ManagerFontSizes.s14,
                        color: ManagerColors.secondaryColor,
                      ),
                    ),
                    minLines: 1,
                    maxLines: 10,
                  ),
                  const SizedBox(height: ManagerHeight.h10),
                  TextField(
                    controller: _contentTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Add Content Note',
                      hintStyle: TextStyle(
                        fontSize: ManagerFontSizes.s14,
                        color: ManagerColors.secondaryColor,
                      ),
                    ),
                    minLines: 1,
                    maxLines: 10,
                  ),
                  const SizedBox(
                    height: ManagerHeight.h24,
                  ),
                  BaseButton(
                    onPressed: () {
                      performCreateNote(controller);
                    },
                    bgColor: ManagerColors.secondaryColor,
                    title: 'Add Note',
                    textStyle: const TextStyle(
                      fontSize: ManagerFontSizes.s20,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> performCreateNote(controller) async {
    if (checkData()) {
      save(controller);
    }
  }

  bool checkData() {
    if (_contentTextEditingController.text.isNotEmpty &&
        _titleTextEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> save(controller) async {
    Note note = Note();
    note.title = _titleTextEditingController.text.toString();
    note.content = _contentTextEditingController.text.toString();
    bool created = await controller.create(note: note);
    if (created) {
      showSnackBar(context: context, message: 'Added Note Successfully');
      Navigator.pushReplacementNamed(context, Routes.homeView);
    } else {
      showSnackBar(
          context: context, message: 'Updated Note Field', error: true);
    }
  }
}
