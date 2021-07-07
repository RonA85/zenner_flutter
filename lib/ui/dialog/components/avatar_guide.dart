
import 'package:flutter/material.dart';
import 'package:zenner_flutter/utils/extenstions/WidgetExtensions.dart';
import 'package:zenner_flutter/utils/styles/colors.dart';

class AvatarGuide extends StatelessWidget{

  final String text;

  const AvatarGuide({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Column(
        children: [
          Image.asset("assets/images/avatar.png").marginWidget(top: 50),
          Text(
            "Dan",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: primary),
          ).marginWidget(top: 11),
          Text("Your Claim Guide", style: TextStyle(color: gray_light))
              .marginWidget(top: 11),
          _buildFirstMessage(text)
        ],
      ).centerWidget();

  Widget _buildFirstMessage(String text) =>
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: purp_light,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            margin: EdgeInsets.only(right: 60, left: 60, top: 8, bottom: 8),
            padding: EdgeInsets.all(16),
            child: Text(
              text,
              style: TextStyle(color: gray_primary),
            ),
          ).expandedWidget(),
        ],
      );


}