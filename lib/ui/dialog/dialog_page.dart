import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zenner_flutter/data/model/message_event.dart';
import 'package:zenner_flutter/di/service_locator.dart';
import 'package:zenner_flutter/stores/dialog_store.dart';
import 'package:zenner_flutter/ui/dialog/components/app_button.dart';
import 'package:zenner_flutter/ui/dialog/components/app_icon_button.dart';
import 'package:zenner_flutter/ui/dialog/components/avatar_guide.dart';
import 'package:zenner_flutter/ui/dialog/components/message_card.dart';
import 'package:zenner_flutter/utils/constants.dart';
import 'package:zenner_flutter/utils/styles/colors.dart';
import 'package:zenner_flutter/utils/extenstions/WidgetExtensions.dart';

final dialogStore = getIt<DialogStore>();

class DialogPage extends StatefulWidget {
  final String username;

  const DialogPage({Key key, this.username}) : super(key: key);

  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> with TickerProviderStateMixin {
  var messages = <MessageEvent>[];
  bool showOptions = false;
  bool approve = false;
  int type = 1;
  ScrollController _scrollController = ScrollController();
  File captureImage;

  _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 100),
    );
  }

  _chooseAnswer(String answer) {
    showOptions = false;
    messages[messages.length - 1] =
        MessageEvent(isHost: false, type: MessageType.TEXT, text: answer);
    setState(() {});
    _showAnswerByQuestion();
  }

  _pickImageFromGallery() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    showOptions = false;
    captureImage = File(pickedFile.path);
    messages[messages.length - 1] = MessageEvent(
        isHost: false, type: MessageType.IMAGE, imageUrl: captureImage);
    setState(() {});
    _progressClaim();
  }

  _pickImageFromCamera() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    showOptions = false;
    captureImage = File(pickedFile.path);
    messages.add(MessageEvent(
        isHost: false, type: MessageType.IMAGE, imageUrl: captureImage));
    setState(() {});
    _progressClaim();
  }

  _progressClaim() async {
    await Future.delayed(Duration(seconds: 1));
    messages.add(MessageEvent(type: MessageType.LOADER));
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    messages.add(MessageEvent(
        isHost: true,
        type: MessageType.TEXT,
        text:
            "It looks like your claim reference is TLVBA47283.\nPlease give me a moment to confirm this with your airline."));
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    messages.add(MessageEvent(type: MessageType.CIRCLE_LOADER));
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    approve = true;
    setState(() {});
  }

  _showAnswerByQuestion() async {
    await Future.delayed(Duration(seconds: 1));
    switch (type) {
      case 1:
        messages.add(MessageEvent(
            isHost: true,
            type: MessageType.TEXT,
            text:
                "Oh no 😩 I'll get you sorted right away. Are you still in the baggage area?"));
        type = 2;
        break;
      case 2:
        messages.add(MessageEvent(
            isHost: true,
            type: MessageType.TEXT,
            text:
                "Great. Now look for Delta's lost baggage counter - ask for the lost bags recipe, and take a photo of it"));
        type = 3;
        break;
      case 3:
        messages.add(MessageEvent(
            isHost: true,
            type: MessageType.TEXT,
            text:
                "Oh no 😩 I'll get you sorted right away. Are you still in the baggage area?"));
        break;
    }
    messages.add(MessageEvent(type: MessageType.EMPTY));
    await Future.delayed(Duration(seconds: 2));
    showOptions = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadFirstMessages();
  }

  _loadFirstMessages() {
    messages.add(MessageEvent(
        type: MessageType.GUIDE,
        isHost: true,
        text:
            "Hi ${widget.username}👋 a pleasure to meet you. I'm here to help you with this claim"));
    setState(() {});
    Timer(Duration(seconds: 2), () {
      messages.add(MessageEvent(
          isHost: true, type: MessageType.TEXT, text: "How can I help"));
      messages.add(MessageEvent(type: MessageType.EMPTY));
      setState(() {});
    });
    Timer(Duration(seconds: 4), () {
      showOptions = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: gray_light,
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu, color: primary),
        actions: [Icon(Icons.refresh, color: primary).paddingWidget(right: 10)],
      ),
      body: !approve
          ? Stack(
              children: [
                _buildMessagesList(),
                _buildOptionalAnswers().visibilityWidget(showOptions),
              ],
            )
          : Column(
              children: [
                Text(
                  "Delayed Bag",
                  style: TextStyle(fontSize: 14),
                ).marginWidget(bottom: 4, top: 40),
                Text(
                  "Claim approved!",
                  style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ).marginWidget(bottom: 24),
                Image.asset("assets/images/ic_claim.png"),
                Text(
                  "We reviewed your claim\n and found it valid.",
                  style: TextStyle(fontSize: 14),
                ).marginWidget(bottom: 30, top: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "\$250",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 74, 112, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("Amount  paid")
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "10 Sec",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 74, 112, 1),
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                        Text("Time to process")
                      ],
                    )
                  ],
                )
              ],
            ),
    );
  }

  Widget _buildMessagesList() => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            controller: _scrollController,
            itemCount: messages.length,
            itemBuilder: (context, i) {
              MessageEvent messageEvent = messages[i];
              if (messageEvent.type == MessageType.GUIDE)
                return AvatarGuide(text: messageEvent.text);
              else
                return MessageCard(messageEvent: messageEvent);
            }),
      );

  Widget _buildAnswer(String answer) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(right: 24, top: 16, bottom: 16, left: 24),
          child: Row(
            children: [
              Text(
                answer,
                style: TextStyle(color: primary, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }

  Widget _buildOptionalAnswers() {
    switch (type) {
      case 1:
        return Positioned(
          bottom: 0,
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: btn,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8))),
              child: Column(
                children: [
                  for (var answer in optional_answers)
                    _buildAnswer(answer)
                        .inkWellWidget(() => _chooseAnswer(answer)),
                ],
              )),
        );
      case 2:
        return Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: btn,
            child: Row(
              children: [
                AppButton(
                  label: "Yes",
                  onTap: () => _chooseAnswer("Yes"),
                ).expandedWidget(),
                AppButton(
                  label: "No",
                  onTap: () => _chooseAnswer("No"),
                ).expandedWidget(),
              ],
            ),
          ),
        );
      case 3:
        return Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: btn,
            child: Row(
              children: [
                AppIconButton(
                  icon: "ic_camera.svg",
                  label: "Take a Photo",
                  onTap: _pickImageFromCamera,
                ).expandedWidget(),
                AppIconButton(
                  icon: "ic_upload.svg",
                  label: "Browse Photos",
                  onTap: _pickImageFromGallery,
                ).expandedWidget(),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
