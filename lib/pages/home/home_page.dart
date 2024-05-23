import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heartly/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: AppColors.heartColor,
        leading: SizedBox(),
        actions: [
          GestureDetector(
            child: Icon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: 26,
            ),
          )
        ],
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
