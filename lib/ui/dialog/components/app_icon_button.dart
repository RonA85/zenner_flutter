import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zenner_flutter/utils/styles/colors.dart';

class AppIconButton extends StatelessWidget {
  final String icon;
  final String label;
  final Function onTap;

  const AppIconButton({Key key, this.icon, this.label, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 70,
      child: ElevatedButton.icon(
          icon: SvgPicture.asset("assets/images/$icon"),
          onPressed: onTap,
          style: ElevatedButton.styleFrom(primary: btn),
          label: Text(
            label,
            style: TextStyle(color: primary),
          )),
    );
  }
}
