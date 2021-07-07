import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zenner_flutter/data/model/message_event.dart';
import 'package:zenner_flutter/ui/dialog/components/gradient_circular_progress.dart';
import 'package:zenner_flutter/utils/extenstions/WidgetExtensions.dart';
import 'package:zenner_flutter/utils/styles/colors.dart';

class MessageCard extends StatelessWidget {
  final MessageEvent messageEvent;

  const MessageCard({Key key, this.messageEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (messageEvent.type) {
      case MessageType.TEXT:
        return Row(
          children: [
            !messageEvent.isHost
                ? Container(
              width: 50,
            )
                : Image.asset(
              "assets/images/avatar.png",
              height: 32,
              width: 32,
            ).marginWidget(left: 22, right: 10),
            Container(
              decoration: BoxDecoration(
                  color: !messageEvent.isHost ? primary : purp_light,
                  borderRadius: !messageEvent.isHost
                      ? BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))
                      : BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              margin: !messageEvent.isHost
                  ? EdgeInsets.only(right: 20, top: 8, bottom: 8)
                  : EdgeInsets.only(right: 60, top: 8, bottom: 8),
              padding: EdgeInsets.all(16),
              child: Text(
                messageEvent.text,
                style: TextStyle(
                    color: !messageEvent.isHost ? Colors.white : gray_primary),
              ),
            ).expandedWidget(),
          ],
        );
      case MessageType.IMAGE:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13.0),
              child: Image.file(
                messageEvent.imageUrl,
                height: 170,
                width: 125,
              ),
            ).marginWidget(right: 16)
          ],
        );
      case MessageType.LOADER:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            children: [
              Text("Done!").marginWidget(bottom: 8),
              Container(
                  height: 6,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(57, 31, 117, 1),
                          Color.fromRGBO(255, 74, 112, 1),
                        ],
                      ))).marginWidget(bottom: 24)
            ],
          ),
        );
      case MessageType.CIRCLE_LOADER:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 36),
          child: Column(
            children: [
              Text(
                "just a moment",
                style: TextStyle(fontSize: 14),
              ).marginWidget(bottom: 4),
              Text(
                "gathering the information",
                style: TextStyle(
                    color: primary, fontWeight: FontWeight.w600, fontSize: 20),
              ).marginWidget(bottom: 8),
              Container(
                width: 86,
                height: 85,
                margin: EdgeInsets.only(top: 16),
                child: GradientCircularProgressIndicator(
                  radius: 40,
                  gradientColors: [
                    Color.fromRGBO(57, 31, 117, 1),
                    Color.fromRGBO(255, 74, 112, 1)
                  ],
                  strokeWidth: 5.0,
                ),
              )
            ],
          ),
        );
      default:
        return Container(height: 100);
    }
  }


}
