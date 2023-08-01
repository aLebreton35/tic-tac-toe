import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_tic_tac_toe/screens/colors.dart';
import 'package:flutter_tic_tac_toe/widgets/button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../widgets/parent_widget.dart';
import 'game_screen.dart';

class PlayerNames extends HookWidget {
  const PlayerNames({super.key});

  Widget buildTextField(String hintText, IconData icon, bool isX,
      ValueSetter<String> onChanged, TextEditingController controller) {
    return TextField(
      cursorColor: isX ? GameColors.kWhitish : GameColors.kPurple,
      style: const TextStyle(color: GameColors.kWhitish),
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        //<-- SEE HERE
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(3.w)),
        ),
        fillColor: GameColors.kForeground,
        hintText: hintText,
        hintStyle: const TextStyle(color: GameColors.kBackground),

        prefixIcon: Icon(
          icon,
          color: isX ? GameColors.kBlue : GameColors.kPurple,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerXController = useTextEditingController();
    final playerOController = useTextEditingController();

    final isBtnEnabled = useValueNotifier(false);
    void checkFields() {
      isBtnEnabled.value = playerXController.text.isNotEmpty &&
          playerOController.text.isNotEmpty;
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: GameColors.kGradient1,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: GameColors.kWhitish,
                ))),
        body: SingleChildScrollView(
          child: ParentContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Enter Player Names',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: GoogleFonts.permanentMarker().fontFamily,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                buildTextField('Player X', Icons.close, true, (value) {
                  print("isEnabled ${isBtnEnabled.value}");
                  checkFields();
                }, playerXController),
                SizedBox(
                  height: 2.h,
                ),
                buildTextField('Player O', Icons.circle_outlined, false,
                    (value) {
                  print("isEnabled ${isBtnEnabled.value}");

                  checkFields();
                }, playerOController),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: 

                HookBuilder(builder: (context) {
                  final isEnabled = useValueListenable(isBtnEnabled);
                  return ButtonWidget(
                      isEnabled: isEnabled,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GameScreen()));
                      },
                      text: 'Start Game');
                })
                ),
              ],
            ),
          ),
        ));
  }
}
