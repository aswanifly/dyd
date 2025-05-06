import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileCountWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;
  final String? type;

  const ProfileCountWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.count,
      this.type});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 6,
      children: [
        type == "faIcon"
            ? FaIcon(FontAwesomeIcons.ticket, color: AppPalette.primaryColor2)
            : Icon(icon, color: AppPalette.darkViolet),
        Text(count, style: TypoPrimary.primary70016),
        Text(title, style: TypoDarkGrey.darkGrey50014,)
      ],
    );
  }
}
