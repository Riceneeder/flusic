import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwAvatar(
        size: 200,
        child: SvgPicture.asset('asset/yoyoos_logo.svg'),
      ),
    );
  }
}
