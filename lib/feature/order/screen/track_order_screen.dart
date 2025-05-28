import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/feature/auth/widget/gradient_container_widget.dart';
import 'package:dyd/feature/cart/view-model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackOrderScreen extends StatelessWidget {
  final String orderId;

  const TrackOrderScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    // Initialize or find CartViewModel
    final CartViewModel controller = Get.find<CartViewModel>();

    // Fetch order data when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchOrderTracking(context, orderId);
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacing.verticalSpace(40),
              // App Logo
              Center(child: Image.asset(ImageHelper.appLogoPNG, height: 80)),
              Spacing.verticalSpace(20),
              // Title
              Center(
                child: Text(
                  'Track Your Order',
                  style: TypoPrimary.primary70025,
                ),
              ),
              Spacing.verticalSpace(10),
              // Order Data or Error State
              Obx(() {
                if (controller.kTrackOrderLoading.value == Status.error) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'Failed to load order tracking',
                          style: TypoDarkGrey.darkGrey50016,
                        ),
                        Spacing.verticalSpace(20),
                        CGradientMaterialButton(
                          onPressed: () =>
                              controller.fetchOrderTracking(context, orderId),
                          child: Text(
                            'Retry',
                            style: TypoPrimary.primary70028,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if (controller.trackOrderModel.value == null) {
                  return Center(
                    child: Text(
                      'No data available',
                      style: TypoDarkGrey.darkGrey50016,
                    ),
                  );
                }

                final data = controller.trackOrderModel.value!;
                return Column(
                  children: [
                    Center(
                      child: Text(
                        'Order ID: ${data.bookingId}',
                        style: TypoPrimary.primary50014,
                      ),
                    ),
                    Spacing.verticalSpace(10),
                    Center(
                      child: Text(
                        'Current Status: ${data.currentStatus}',
                        style: TypoPrimary.primary70016.copyWith(
                          color: AppPalette.primaryColor1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacing.verticalSpace(20),
                    // Timeline Card
                    Card(
                      elevation: 2,
                      color: AppPalette.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Timeline',
                              style: TypoDarkGrey.darkGrey70016,
                            ),
                            Spacing.verticalSpace(10),
                            ...data.timeline.asMap().entries.map((entry) {
                              final index = entry.key;
                              final item = entry.value;

                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Timeline Dot and Line
                                      Column(
                                        children: [
                                          Container(
                                            width: 16,
                                            height: 16,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppPalette.primaryColor1,
                                            ),
                                          ),
                                          if (index < data.timeline.length - 1)
                                            Container(
                                              width: 2,
                                              height: 40,
                                              color: AppPalette.lightGrey,
                                            ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      // Timeline Content
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title,
                                              style: TypoDarkGrey.darkGrey70016,
                                            ),
                                            Text(
                                              item.status,
                                              style: TypoDarkGrey.darkGrey50014,
                                            ),
                                            Text(
                                              item.formattedDate,
                                              style: TypoDarkGrey.darkGrey50012,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (index < data.timeline.length - 1)
                                    Spacing.verticalSpace(10),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
              Spacing.verticalSpace(20),
              // Back Button
              Center(
                child: CGradientMaterialButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate back
                  },
                  child: Text(
                    'Back',
                    style: TypoWhite.white70016,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
