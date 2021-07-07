// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DialogStore on _DialogStore, Store {
  final _$heightAtom = Atom(name: '_DialogStore.height');

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$messagesAtom = Atom(name: '_DialogStore.messages');

  @override
  List<MessageEvent> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<MessageEvent> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$answersAtom = Atom(name: '_DialogStore.answers');

  @override
  List<String> get answers {
    _$answersAtom.reportRead();
    return super.answers;
  }

  @override
  set answers(List<String> value) {
    _$answersAtom.reportWrite(value, super.answers, () {
      super.answers = value;
    });
  }

  final _$chooseAnswerAsyncAction = AsyncAction('_DialogStore.chooseAnswer');

  @override
  Future<void> chooseAnswer(String answer) {
    return _$chooseAnswerAsyncAction.run(() => super.chooseAnswer(answer));
  }

  final _$_DialogStoreActionController = ActionController(name: '_DialogStore');

  @override
  void loadFirstMessage(String username) {
    final _$actionInfo = _$_DialogStoreActionController.startAction(
        name: '_DialogStore.loadFirstMessage');
    try {
      return super.loadFirstMessage(username);
    } finally {
      _$_DialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void hostAnswer() {
    final _$actionInfo = _$_DialogStoreActionController.startAction(
        name: '_DialogStore.hostAnswer');
    try {
      return super.hostAnswer();
    } finally {
      _$_DialogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
height: ${height},
messages: ${messages},
answers: ${answers}
    ''';
  }
}
