import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:dyd/feature/lucky-card/screen/discount_cards_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDiscountCardDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: AppPalette.primaryColor2,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageHelper.discountcheck,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Get.to(() => DiscountCardListScreen());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(202, 48),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text('Buy Discount Card'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  showCustomSnackBar(
                      context, "Buy Discount Card,Unlock Discount Benefits ");
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(202, 48),
                  backgroundColor: Colors.white.withOpacity(0.3),
                  foregroundColor: Colors.white.withOpacity(0.9),
                  elevation: 0,
                  disabledForegroundColor: Colors.white.withOpacity(0.9),
                  disabledBackgroundColor: Colors.white.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Proceed Without Discount Card',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
