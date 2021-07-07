import 'package:flutter/material.dart';
import 'package:zenner_flutter/utils/styles/colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const AppButton({Key key, this.label, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 70,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(primary: btn),
          child: Text(
            label,
            style: TextStyle(color: primary),
          )),
    );
  }
}
