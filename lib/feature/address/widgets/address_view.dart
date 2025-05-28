import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/blue_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/image-widget/cached_network_image.dart';
import 'package:dyd/feature/address/view-model/address_view_model.dart';
import 'package:dyd/feature/address/widgets/add_new_address_view.dart';
import 'package:dyd/feature/address/widgets/edit_address_view.dart';
import 'package:dyd/model/address-model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:logger/logger.dart';

class AddressView extends StatefulWidget {
  final String? screen;

  const AddressView({super.key, this.screen});

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final addressViewModel = Get.put(AddressViewModel());

  @override
  void initState() {
    addressViewModel.fGetCurrentLocationAddress();
    addressViewModel.fGetAddedAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text("My Address")),
          body: Obx(() => addressViewModel.kGetLoadingStatus.value ==
                  Status.loading
              ? Center(child: const CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSearchAndAddAddress(addressViewModel),
                      Spacing.verticalSpace(10),
                      InkWell(
                        onTap: () {
                          addressViewModel
                              .getCurrentLocationWithAddressDetailsForAddingAddress(
                                  context);
                          Get.to(() => AddNewAddress());
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          elevation: 0,
                          color: AppPalette.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.my_location,
                                    color: AppPalette.blue,
                                  ),
                                  Spacing.horizontalSpace(10),
                                  Text("Location", //"Current location",
                                      style: TypoBlue.blue50014),
                                ],
                              ),
                              Obx(() => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35),
                                    child: Text(
                                        addressViewModel
                                            .kCurrentLocationAddressForAddress
                                            .value,
                                        style: TypoBlack.black50012),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      // ListTile(
                      //   leading:
                      //       const Icon(Icons.my_location, color: AppPalette.blue),
                      //   title:
                      //       Text("Current location", style: TypoBlue.blue50012),
                      //   subtitle: Obx(() => Text(
                      //       addressViewModel
                      //           .kCurrentLocationAddressForAddress.value,
                      //       style: TypoBlack.black50010)),
                      //   onTap: () => addressViewModel
                      //       .getCurrentLocationWithAddressDetailsForAddingAddress(
                      //           context),
                      // ),
                      Spacing.verticalSpace(10),
                      const Divider(color: AppPalette.lightGrey),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Saved ", style: TypoBlue.blue50014),
                            Spacing.verticalSpace(4),
                            buildSavedAddressWidget(context),
                            Spacing.verticalSpace(10),
                            // Flexible(
                            //   child: addressViewModel.kAllAddressList.isEmpty
                            //       ? Center(
                            //           child: Text("No address available",
                            //               style: TypoBlack.black50012),
                            //         )
                            //       : ListView.builder(
                            //           itemCount:
                            //               addressViewModel.kAllAddressList.length,
                            //           itemBuilder: (context, index) => InkWell(
                            //             onTap: () {
                            //               AddressDetailModel addressModel =
                            //                   addressViewModel.kAllAddressList[index];
                            //               //if no screen specified that means going for address
                            //               if (widget.screen == null) {
                            //                 addressViewModel.fSetDefaultAddress(
                            //                     context, addressModel.id);
                            //                 return;
                            //               }
                            //               //update address for labour and home
                            //               if (widget.screen == "home") {
                            //                 Get.find<LabourViewModel>()
                            //                     .kSelectedAddress(addressItem
                            //                         .address!
                            //                         .area);
                            //                 Get.find<HomeViewModel>().kCurrentAddress(
                            //                     addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 Get.find<HomeViewModel>()
                            //                     .kSelectedAddressId(addressItem.id);
                            //                 addressViewModel.fSetDefaultAddress(
                            //                     context, addressModel.id);
                            //                 return;
                            //               }
                            //               if (widget.screen == "labour") {
                            //                 final labourViewModel =
                            //                     Get.find<LabourViewModel>();
                            //                 labourViewModel.kSelectedAddress(
                            //                     addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 labourViewModel.kAddressLongitude(
                            //                     addressViewModel.kAllAddressList[index]
                            //                         .location!.coordinates[1]);
                            //                 labourViewModel.kAddressLatitude(
                            //                     addressViewModel.kAllAddressList[index]
                            //                         .location!.coordinates[0]);
                            //                 Get.find<HomeViewModel>().kCurrentAddress(
                            //                     addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 Get.find<HomeViewModel>()
                            //                     .kSelectedAddressId(addressItem.id);
                            //                 //fetch list from updated address
                            //                 labourViewModel
                            //                     .fGetSelectedLabourFromCategoryLocation(
                            //                         context,
                            //                         labourViewModel
                            //                             .kSelectedLabourCategoryId
                            //                             .value);
                            //                 Get.back();
                            //               }
                            //
                            //               if (widget.screen == "addLabourJob") {
                            //                 final CategoryLabourViewModel
                            //                     categoryLabourViewModel =
                            //                     Get.find<CategoryLabourViewModel>();
                            //                 categoryLabourViewModel.kAddressTxt.text =
                            //                     addressModel.address!.area;
                            //                 categoryLabourViewModel
                            //                     .kSelectedAddressIdForLabourJob(
                            //                         addressModel.id);
                            //                 Get.back();
                            //                 return;
                            //               }
                            //               if (widget.screen == "labourRequest") {
                            //                 final labourViewModel =
                            //                     Get.find<LabourViewModel>();
                            //                 labourViewModel.kAddressTxt.text =
                            //                     addressModel.address!.area;
                            //                 labourViewModel
                            //                     .kSelectedAddressIdForLabourRequest(
                            //                         addressModel.id);
                            //                 Get.back();
                            //                 return;
                            //               }
                            //               if (widget.screen == "machinery") {
                            //                 final machineryViewModel =
                            //                     Get.put<MachineryViewModel>(
                            //                         MachineryViewModel());
                            //                 machineryViewModel.kCurrentAddress(
                            //                     addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 machineryViewModel.kSelectedAddressId(
                            //                     addressItem.id);
                            //                 Get.back();
                            //               }
                            //               if (widget.screen == "land") {
                            //                 final landViewModel =
                            //                     Get.put<LandServiceViewModel>(
                            //                         LandServiceViewModel());
                            //                 landViewModel.kSelectedAddress(
                            //                     addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 landViewModel.kSelectedAddressId(
                            //                     addressItem.id);
                            //                 Get.back();
                            //               }
                            //               if (widget.screen == "livestock") {
                            //                 final landViewModel =
                            //                     Get.put<LiveStockViewController>(
                            //                         LiveStockViewController());
                            //                 landViewModel.kSelectedAddress(
                            //                     addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 landViewModel.kSelectedAddressId(
                            //                     addressItem.id);
                            //                 Get.back();
                            //               }
                            //               if (widget.screen == "machinery_category") {
                            //                 Get.find<CategoryMachineryController>()
                            //                         .kAddressTxt
                            //                         .text =
                            //                     (addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 Get.find<CategoryMachineryController>()
                            //                     .kSelectedAddressId(addressItem.id);
                            //                 Get.back();
                            //               }
                            //               if (widget.screen == "land_category") {
                            //                 Get.find<CategoryLandServiceController>()
                            //                         .kAddressTxt
                            //                         .text =
                            //                     (addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 Get.find<CategoryLandServiceController>()
                            //                     .kSelectedAddressId(addressItem.id);
                            //                 Get.back();
                            //               }
                            //               if (widget.screen == "livestock_category") {
                            //                 Get.find<CategoryLiveStockController>()
                            //                         .locationController
                            //                         .text =
                            //                     (addressViewModel.kAllAddressList[index]
                            //                         .address!.area);
                            //                 Get.find<CategoryLiveStockController>()
                            //                     .kSelectedAddressId(addressItem.id);
                            //                 Get.back();
                            //               }
                            //             },
                            //             child: Obx(() => Card(
                            //                   elevation: 0,
                            //                   color: AppPalette.white,
                            //                   shape: RoundedRectangleBorder(
                            //                     borderRadius: BorderRadius.circular(8),
                            //                     side: BorderSide(
                            //                         // color: addressViewModel
                            //                         //             .kAllAddressList[index]
                            //                         //             .id ==
                            //                         //         Get.find<HomeViewModel>()
                            //                         //             .kSelectedAddressId
                            //                         //             .value
                            //                         //     ? AppPalette.primaryColor
                            //                         //     : AppPalette.lightGrey,
                            //                         color: addressViewModel
                            //                                 .kAllAddressList[index]
                            //                                 .isDefaultAddress
                            //                             ? AppPalette.primaryColor
                            //                             : AppPalette.lightGrey,
                            //                         width: 2),
                            //                   ),
                            //                   child: Padding(
                            //                     padding: const EdgeInsets.all(8.0),
                            //                     child: Row(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.start,
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment.center,
                            //                       children: [
                            //                         Icon(Icons.location_on,
                            //                             size: 35,
                            //                             color: AppPalette.grey
                            //                                 .withOpacity(0.5)),
                            //                         Spacing.horizontalSpace(14),
                            //                         // SizedBox(
                            //                         //     height: 80,
                            //                         //     width: 56,
                            //                         //     child: ClipRRect(
                            //                         //       borderRadius:
                            //                         //           BorderRadius.circular(8),
                            //                         //       child: const CCachedNetworkImage(
                            //                         //           imageLink:
                            //                         //               "https://cdn.pixabay.com/photo/2021/11/15/14/50/lake-6798400_1280.jpg"),
                            //                         //     )),
                            //                         // Spacing.horizontalSpace(10),
                            //                         Expanded(
                            //                           child: Column(
                            //                             mainAxisAlignment:
                            //                                 MainAxisAlignment
                            //                                     .spaceBetween,
                            //                             crossAxisAlignment:
                            //                                 CrossAxisAlignment.start,
                            //                             children: [
                            //                               buildEditDelete(
                            //                                   addressViewModel
                            //                                           .kAllAddressList[
                            //                                       index]),
                            //                               addressViewModel
                            //                                       .kAllAddressList[
                            //                                           index]
                            //                                       .name
                            //                                       .isEmpty
                            //                                   ? const SizedBox()
                            //                                   : Column(
                            //                                       mainAxisAlignment:
                            //                                           MainAxisAlignment
                            //                                               .start,
                            //                                       crossAxisAlignment:
                            //                                           CrossAxisAlignment
                            //                                               .start,
                            //                                       children: [
                            //                                         Spacing
                            //                                             .verticalSpace(
                            //                                                 5),
                            //                                         Text(
                            //                                             addressViewModel
                            //                                                 .kAllAddressList[
                            //                                                     index]
                            //                                                 .name,
                            //                                             style: TypoBlack
                            //                                                 .black60012),
                            //                                       ],
                            //                                     ),
                            //                               addressViewModel
                            //                                       .kAllAddressList[
                            //                                           index]
                            //                                       .phone
                            //                                       .isEmpty
                            //                                   ? const SizedBox()
                            //                                   : Column(
                            //                                       mainAxisAlignment:
                            //                                           MainAxisAlignment
                            //                                               .start,
                            //                                       crossAxisAlignment:
                            //                                           CrossAxisAlignment
                            //                                               .start,
                            //                                       children: [
                            //                                         Spacing
                            //                                             .verticalSpace(
                            //                                                 5),
                            //                                         Text(
                            //                                             addressViewModel
                            //                                                 .kAllAddressList[
                            //                                                     index]
                            //                                                 .phone,
                            //                                             style: TypoBlack
                            //                                                 .black40012),
                            //                                       ],
                            //                                     ),
                            //                               Spacing.verticalSpace(5),
                            //                               Text(
                            //                                   addressViewModel
                            //                                       .kAllAddressList[
                            //                                           index]
                            //                                       .address!
                            //                                       .area,
                            //                                   style:
                            //                                       TypoBlack.black40010),
                            //                             ],
                            //                           ),
                            //                         )
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 )),
                            //           ),
                            //         ),
                            // ),
                            // Obx(() =>
                            //     addressViewModel.kSearchEnabled.value == true
                            //         ? const SizedBox()
                            //         : SingleChildScrollView(
                            //             child: Column(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.start,
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Text("search",
                            //                     style: TypoBlue.blue50014),
                            //                 Spacing.verticalSpace(4),
                            //                 buildSearchedAddressWidget(context),
                            //               ],
                            //             ),
                            //           ))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
        ),
        Obx(() => addressViewModel.kOverLayAddressLoadingStatus.value ==
                Status.loading
            ? const CircularProgressIndicator()
            : const SizedBox())
      ],
    );
  }

  // Column buildSearchedAddressWidget(BuildContext context) {
  //   return Column(
  //     children: [
  //       if (addressViewModel.kSearchedAddressList.isNotEmpty)
  //         ...addressViewModel.kSearchedAddressList.map((addressItem) => InkWell(
  //             onTap: () {
  //               AddressDetailModel addressModel = addressItem;
  //             },
  //             child: SizedBox(
  //               height: 100,
  //               child: Card(
  //                 elevation: 0,
  //                 color: AppPalette.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                   side: BorderSide(
  //                     color: addressItem.isDefault
  //                         ? AppPalette.primaryColor1
  //                         : AppPalette.lightGrey,
  //                     width: 2,
  //                   ),
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(12.0),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Icon(Icons.location_on,
  //                           size: 30, color: AppPalette.blue.withOpacity(0.5)),
  //                       Spacing.horizontalSpace(10),
  //                       ClipRRect(
  //                         borderRadius: BorderRadius.circular(8),
  //                         child: const SizedBox(
  //                           height: 60,
  //                           width: 60,
  //                           child: CCachedNetworkImage(
  //                             imageLink:
  //                                 "https://cdn.pixabay.com/photo/2021/11/15/14/50/lake-6798400_1280.jpg",
  //                           ),
  //                         ),
  //                       ),
  //                       Spacing.horizontalSpace(10),

  //                       /// Main Content Column
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             /// Top Row: Edit/Delete Buttons
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               children: [
  //                                 GestureDetector(
  //                                   onTap: () {
  //                                     // Navigate to edit
  //                                   },
  //                                   child: const Icon(Icons.edit_outlined,
  //                                       color: Colors.black54),
  //                                 ),
  //                                 Spacing.horizontalSpace(10),
  //                                 GestureDetector(
  //                                   onTap: () {
  //                                     // Confirm delete dialog
  //                                   },
  //                                   child: const Icon(Icons.delete_outline,
  //                                       color: Colors.black54),
  //                                 ),
  //                               ],
  //                             ),
  //                             Spacing.verticalSpace(6),

  //                             /// Name
  //                             if (addressItem.name.isNotEmpty) ...[
  //                               Text(addressItem.name,
  //                                   style: TypoBlack.black40016),
  //                               Spacing.verticalSpace(4),
  //                             ],

  //                             /// Phone
  //                             if (addressItem.phone.isNotEmpty) ...[
  //                               Text(addressItem.phone,
  //                                   style: TypoBlack.black40012),
  //                               Spacing.verticalSpace(4),
  //                             ],

  //                             /// Area
  //                             Text(addressItem.area,
  //                                 style: TypoBlack.black40012),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ))),
  //       if (addressViewModel.kSearchedAddressList.isEmpty)
  //         Align(
  //             alignment: Alignment.center,
  //             child: Text("No searched address", style: TypoBlack.black50012))
  //     ],
  //   );
  // }

  Widget buildSavedAddressWidget(BuildContext context) {
    return Obx(() => Column(
          children: [
            if (addressViewModel.kAllAddressList.isNotEmpty)
              ...addressViewModel.kAllAddressList.map((addressItem) => InkWell(
                    onTap: () {
                      AddressDetailModel addressModel = addressItem;
                      if (widget.screen == null) {
                        addressViewModel.fSetDefaultAddress(
                            context, addressModel.id);
                        return;
                      }
                    },
                    child: Card(
                      elevation:
                          1, // Slight elevation for better visual separation
                      color: AppPalette.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: addressItem.isDefault
                              ? AppPalette.primaryColor1
                              : AppPalette.lightGrey,
                          width: 1.5, // Reduced width for a subtler border
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                            horizontal: 16.0), // Consistent padding
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align to top for better control
                          children: [
                            // Location Icon
                            Icon(
                              Icons.location_on,
                              size: 35,
                              color: AppPalette.black.withOpacity(0.5),
                            ),
                            const SizedBox(width: 16), // Consistent spacing
                            // Address Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name
                                  if (addressItem.name.isNotEmpty)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: Text(
                                        addressItem.name,
                                        style: TypoBlack.black40012,
                                      ),
                                    ),
                                  // Phone
                                  if (addressItem.phone.isNotEmpty)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: Text(
                                        addressItem.phone,
                                        style: TypoBlack.black40012,
                                      ),
                                    ),
                                  // Area
                                  Text(
                                    addressItem.area,
                                    style: TypoBlack.black40012,
                                  ),
                                ],
                              ),
                            ),
                            // Edit and Delete Buttons
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Uncomment and implement edit functionality
                                    Get.to(() => EditNewAddressView(
                                        addressDetailModel: addressItem));
                                  },
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: AppPalette.black.withOpacity(0.5),
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12), // Consistent spacing
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: AppPalette.white,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.help,
                                              color: Colors.red,
                                              size: 50,
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              "Do you want to delete the address?",
                                              style: TypoBlack.black50016,
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 15),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: MaterialButton(
                                                    onPressed: () => Get.back(),
                                                    color: AppPalette.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                          color: const Color
                                                              .fromARGB(255, 64,
                                                              49, 100)),
                                                    ),
                                                    child: Text("No",
                                                        style: TypoPrimary
                                                            .primary50014),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: MaterialButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                          color: const Color
                                                              .fromARGB(255, 64,
                                                              49, 100)),
                                                    ),
                                                    color: AppPalette
                                                        .primaryColor1,
                                                    onPressed: () {
                                                      addressViewModel
                                                          .fDeleteAddress(
                                                              context,
                                                              addressItem.id);
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                      "Yes",
                                                      style:
                                                          TypoWhite.white40014,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: AppPalette.black.withOpacity(0.5),
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            if (addressViewModel.kAllAddressList.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "No Saved Addresses",
                  style: TypoBlack.black50016.copyWith(
                    color: AppPalette.black.withOpacity(0.7),
                  ),
                ),
              ),
          ],
        ));
  }

  Padding buildSearchAndAddAddress(AddressViewModel addressViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 50,
              child: SearchBar(
                controller: addressViewModel.kAddressSearchTxt,
                elevation: WidgetStateProperty.all(0),
                backgroundColor: WidgetStateProperty.all(Colors.white),
                side: WidgetStateProperty.all(
                    const BorderSide(color: AppPalette.lightGrey)),
                leading: const Icon(Icons.search_rounded, color: Colors.grey),
                padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 15)),
                hintText: "Search address here",
                hintStyle: WidgetStateProperty.all(TypoBlack.black40014),
                onChanged: (value) {
                  addressViewModel.fSearchAddress(value);
                },
                trailing: [
                  IconButton(
                      onPressed: () {
                        addressViewModel.kSearchEnabled(false);
                        addressViewModel.fSearchAddress("");
                      },
                      icon: Icon(Icons.close))
                ],
              ),
            ),
          ),
          Spacing.horizontalSpace(10),
          // CMaterialButton(
          //   minWidth: 75,
          //   elevation: 0,
          //   height: 40,
          //   onPressed: () => Get.to(() => const AddNewAddress()),
          //   color: AppPalette.white,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(4),
          //     side: const BorderSide(color: AppPalette.grey),
          //   ),
          //   child:
          //       Text(GlobalAppText.ADD_ADDRESS.tr, style: TypoBlack.black40010),
          // )
        ],
      ),
    );
  }

  Widget buildEditDelete(AddressDetailModel addressDetailModel) {
    return addressDetailModel.addressType.isEmpty
        ? const SizedBox()
        : Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            color: AppPalette.lightGrey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                addressDetailModel.addressType,
                style: TypoBlue.blue50014,
              ),
            ),
          );
  }
}
