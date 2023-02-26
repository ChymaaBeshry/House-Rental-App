import 'package:flutter/material.dart';
import 'package:newproject/view/shared_theme/shared_colors.dart';
import 'package:newproject/view/shared_theme/share_fonts.dart';
import 'package:newproject/View/space/BottomNavigationBarScreen/moreScreen.dart';

class FABScreen extends StatefulWidget {
  @override
  State<FABScreen> createState() => _FABScreenState();
}

class _FABScreenState extends State<FABScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColors.BackGraundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: SharedColors.BackGraundColor,
        title: Text(
          "FAB",
          style: SharedFonts.primaryOrangeFont,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: SharedColors.OrangeColor,
      ),
    );
  }

}