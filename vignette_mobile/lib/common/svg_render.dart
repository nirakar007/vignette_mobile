import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgRender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        'assets/logo/logo_vignette.svg',
        semanticsLabel: 'Logo',
      ),
    );
  }
}
