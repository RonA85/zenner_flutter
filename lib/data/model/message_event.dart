
import 'dart:io';

enum MessageType{
  GUIDE,TEXT, IMAGE,EMPTY,LOADER,CIRCLE_LOADER
}

class MessageEvent {
  bool isHost;
  String text;
  File imageUrl;
  MessageType type;
  MessageEvent({this.isHost,this.text,this.imageUrl,this.type});
}
