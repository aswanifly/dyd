import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/blue_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            _buildNavItem(ImageHelper.bnHome, "Home", 0),
            _buildNavItem(ImageHelper.bnTag, "Lucky Card", 1),
            _buildNavItem(ImageHelper.bnCart, "Cart", 2),
            _buildNavItem(ImageHelper.bnProfile, "Profile", 3),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: AppPalette.darkViolet,
          unselectedItemColor: AppPalette.darkGrey,
          selectedLabelStyle: TypoBlue.blue50014,
          onTap: onItemSelected,
          backgroundColor: AppPalette.white,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  /// Helper function to build BottomNavigationBarItem
  BottomNavigationBarItem _buildNavItem(
      String iconPath, String label, int index) {
    bool isSelected = selectedIndex == index;

    return BottomNavigationBarItem(
      icon: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: SvgPicture.asset(
            iconPath,
            color: isSelected ? AppPalette.darkViolet : Colors.grey,
          )),
      label: label,
      activeIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: SvgPicture.asset(
            iconPath,
            color: isSelected ? AppPalette.darkViolet : Colors.grey,
          )),
    );
  }
}
