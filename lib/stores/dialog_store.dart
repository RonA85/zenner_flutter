import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:zenner_flutter/data/model/message_event.dart';

part 'dialog_store.g.dart';

class DialogStore = _DialogStore with _$DialogStore;

abstract class _DialogStore with Store {
  var optionalAnswers = [
    "My bags haven't arrived",
    "My trip got disrupted",
    "I don't feel well",
    "Emergency",
    "Others"
  ];

  // store variables:-----------------------------------------------------------
  @observable
  double height = 0.0;

  @observable
  var messages = <MessageEvent>[];

  @observable
  var answers = <String>[];

  // @observable
  // ObservableFuture<User> loginFuture = emptyLoginResponse;
  //
  // @computed
  // bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------

  @action
  void loadFirstMessage(String username) {
    messages.add(MessageEvent(
        isHost: true,
        text:
            "Hi $username👋 a pleasure to meet you. I'm here to help you with this claim"));
    Timer(Duration(seconds: 2), () {
      messages.add(MessageEvent(isHost: true, text: "How can I help"));
    });
    Timer(Duration(seconds: 4), () {
      answers = optionalAnswers;
    });
  }

  @action
  Future<void> chooseAnswer(String answer) async {
    messages.add(MessageEvent(isHost: false, text: answer));
    answers = [];
    //Future.delayed( Duration(milliseconds: 2500));
    hostAnswer();
    // Future.delayed(Duration(seconds: 5), () {
    //   messages.add(MessageEvent(
    //       isHost: true,
    //       text:
    //           "Oh no 😩 I'll get you sorted right away. Are you still in the baggage area?"));
    // });
  }

  @action
  void hostAnswer(){
    Timer(Duration(seconds: 5), () {
      messages.add(MessageEvent(
          isHost: true,
          text:
          "Oh no 😩 I'll get you sorted right away. Are you still in the baggage area?"));
    });
  }
}
