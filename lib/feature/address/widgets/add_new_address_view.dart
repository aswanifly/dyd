import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/blue_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/c_recative_material_button.dart';
import 'package:dyd/core/widget/text-field-widget/c_text_field_widget.dart';
import 'package:dyd/feature/address/view/google_map_view.dart';
import 'package:dyd/feature/address/widgets/map_search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/config/spacing/static_spacing_helper.dart';
import '../../../core/config/theme/app_palette.dart';
import '../view-model/address_view_model.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  AddressViewModel addressViewModel = Get.find<AddressViewModel>();

  // LandingViewModel landingViewModel = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    addressViewModel.checkLocationAccessAndCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Obx(() => addressViewModel.isAddressSelected.isTrue
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              // height: context.dynamicHeight(
              //     addressViewModel.addMoreDetail.isTrue ? 0.65 : 0.28),
              width: double.infinity,
              color: AppPalette.white,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.blueAccent,
                        ),
                        Spacing.horizontalSpace(10),
                        const Text("Pinned location"),
                      ],
                    ),
                    //selected address card
                    buildSelectedAddressTextCard(),
                    Spacing.verticalSpace(20),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              bAddressDetailBottomSheet(context);
                            },
                            child: Text(
                              "Add more details",
                              style: TypoBlue.blue50014,
                            ),
                          ),
                          // child: CMaterialButton(
                          //   color: AppPalette.white,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(8),
                          //       side: const BorderSide(
                          //           color: AppPalette.primaryColor)),
                          //   onPressed: () {
                          //     // addressViewModel.addMoreDetail(true);
                          //     bAddressDetailBottomSheet(context);
                          //   },
                          //   child: Text(
                          //     "Add more details",
                          //     style: TypoprimaryColor.primaryColor50014,
                          //   ),
                          // ),
                        ),
                        Spacing.horizontalSpace(10),
                        Expanded(
                          child: Obx(() => CReactiveMaterialButton(
                              isLoading:
                                  addressViewModel.addingLoadingStatus.value ==
                                      Status.loading,
                              buttonName: "Continue",
                              textStyle: TypoWhite.white40014,
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                addressViewModel.fAddAddress(
                                    context, "continue");
                                // addressViewModel
                                //     .addMoreDetail(false);
                                // }
                              })),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : const SizedBox()),
      appBar: AppBar(
        title: const Text("Location"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            //google map
            const Align(alignment: Alignment.center, child: CGoogleMap()),
            //address search bar
            Positioned(
                top: 50, left: 10, right: 10, child: buildSearchBar(context)),
          ],
        ),
      ),
    );
  }

  Future<dynamic> bAddressDetailBottomSheet(BuildContext context) {
    // addressViewModel.phoneTxt.text = ;
    // addressViewModel.nameTxt.text = landingViewModel.userName.value;
    // addressViewModel.selectedAddressType("Home");
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppPalette.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Enter complete address",
                              style: TypoBlack.black50016,
                            ),
                            IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        const Divider(),
                        Text(
                          "Save address as",
                          style: TypoBlack.black40012,
                        ),
                        Spacing.verticalSpace(8),
                        Row(
                          children: [
                            bChipsWidget("Home"),
                            Spacing.horizontalSpace(10),
                            bChipsWidget("Property"),
                            Spacing.horizontalSpace(10),
                            bChipsWidget("Farm Land"),
                          ],
                        ),
                        Spacing.verticalSpace(10),
                        buildLocationDetailCard(),
                        Spacing.verticalSpace(15),
                        //contact person detail
                        buildContactDetailsCard(),
                        Spacing.verticalSpace(15),
                        Obx(() => CReactiveMaterialButton(
                            isLoading:
                                addressViewModel.addingLoadingStatus.value ==
                                    Status.loading,
                            buttonName: "Save address",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                addressViewModel.fAddAddress(
                                    context, "addMoreDetail");
                                // addressViewModel
                                //     .addMoreDetail(false);
                              }
                            })),
                        // CMaterialButton(
                        //     child: Text(
                        //       "Save address",
                        //       style: TypoWhite.white50014,
                        //     ),
                        //     onPressed: () {
                        //       if (_formKey.currentState!.validate()) {
                        //         addressViewModel.fAddAddress(context);
                        //         // addressViewModel
                        //         //     .addMoreDetail(false);
                        //       }
                        //     })
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget bChipsWidget(String name) {
    return Obx(() => GestureDetector(
          onTap: () => addressViewModel.selectedAddressType(name),
          child: Chip(
            label: Text(
              name,
              style: TypoBlack.black50014,
            ),
            // color:,
            elevation: 0,
            backgroundColor: addressViewModel.selectedAddressType.value == name
                ? AppPalette.primaryColor1.withOpacity(0.1)
                : AppPalette.white,
            visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    color: addressViewModel.selectedAddressType.value == name
                        ? AppPalette.primaryColor1
                        : AppPalette.black)),
          ),
        ));
  }

  SizedBox buildSelectedAddressTextCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: const RoundedRectangleBorder(),
        color: AppPalette.lightGrey,
        surfaceTintColor: AppPalette.lightGrey,
        elevation: 0,
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addressViewModel.selectedAddressTitleText.value,
                    style: TypoBlack.black50016,
                  ),
                  Spacing.verticalSpace(2),
                  Text(
                    addressViewModel.selectedAddressSubTitleText.value,
                    style: TypoBlue.blue50014,
                  )
                ],
              ),
            )),
      ),
    );
  }

  SizedBox buildLocationDetailCard() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CTextField(
            controller: addressViewModel.newAddressTxt,
            fillColor: AppPalette.white,
            filled: true,
            label: const Text("Block/Door No/Flat No/Street name"),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter Street";
              }
              return null;
            },
          ),
          Spacing.verticalSpace(13),
          CTextField(
            controller: addressViewModel.floorTxt,
            fillColor: AppPalette.white,
            filled: true,
            label: const Text("Floor(optional)"),
          ),
          Spacing.verticalSpace(13),
          SizedBox(
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              elevation: 0,
              color: AppPalette.lightGrey.withOpacity(0.8),
              surfaceTintColor: AppPalette.lightGrey.withOpacity(0.8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                    "${addressViewModel.selectedAddressTitleText.value}\n${addressViewModel.selectedAddressSubTitleText.value}"),
              ),
            ),
          ),
          Spacing.verticalSpace(13),
          CTextField(
            controller: addressViewModel.landmarkTxt,
            fillColor: AppPalette.white,
            filled: true,
            label: const Text("Nearby landmark(optional)"),
          )
        ],
      ),
    );
  }

  SizedBox buildContactDetailsCard() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter your detail",
            style: TypoBlack.black40012,
          ),
          Spacing.verticalSpace(10),
          CTextField(
            controller: addressViewModel.nameTxt,
            label: const Text("Name"),
            fillColor: AppPalette.white,
            filled: true,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter name";
              }
              return null;
            },
          ),
          Spacing.verticalSpace(13),
          CTextField(
            controller: addressViewModel.phoneTxt,
            label: const Text("Phone number"),
            maxLength: 10,
            keyboardType: TextInputType.number,
            fillColor: AppPalette.white,
            filled: true,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter phone number";
              } else if (value.length != 10) {
                return "Enter 10 digit number";
              }
              return null;
            },
          )
        ],
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Obx(() => Row(
          children: [
            Expanded(
              child: TextField(
                // controller: addressViewModel.searchController,
                autofocus: false,
                readOnly: true,
                onTap: () {
                  addressViewModel.searchController.clear();
                  addressViewModel.searchedAddressResultList.clear();
                  Get.to(() => const SearchAddressView());
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppPalette.white,
                    hintText: 'Search Location',
                    hintStyle: TypoBlue.blue50014,
                    suffixIconConstraints:
                        const BoxConstraints(minHeight: 20, minWidth: 30),
                    suffixIcon: addressViewModel
                                .searchingAddressLoadingStatus.value ==
                            Status.loading
                        ? Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  color: AppPalette.primaryColor1,
                                )),
                          )
                        : Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.search, color: AppPalette.black),
                          ),
                    //const Icon(Icons.search, color: AppPalette.grey),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15)),
              ),
            ),
            Card(
                elevation: 0,
                color: AppPalette.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: AppPalette.blue)),
                child: IconButton(
                    onPressed: () {
                      addressViewModel
                          .kMapType(!addressViewModel.kMapType.value);
                    },
                    icon: addressViewModel.kMapType.isFalse
                        ? const Icon(
                            Icons.satellite,
                            color: AppPalette.black,
                          )
                        : Icon(
                            Icons.terrain,
                            color: AppPalette.audioColor1,
                          )))
          ],
        ));
    // return TypeAheadField(
    //   suggestionsCallback: (search) => addressViewModel.searchAddress(search),
    //   constraints: BoxConstraints(maxHeight: context.dynamicHeight(0.2)),
    //   builder: (context, controller, focusNode) {
    //     return Obx(() => TextField(
    //           controller: controller,
    //           focusNode: focusNode,
    //           autofocus: false,
    //           decoration: InputDecoration(
    //               filled: true,
    //               fillColor: AppPalette.white,
    //               hintText: 'Search Location',
    //               hintStyle: TypoGrey.grey40015,
    //               suffixIconConstraints:
    //                   const BoxConstraints(minHeight: 20, minWidth: 30),
    //               suffixIcon:
    //                   addressViewModel.searchingAddressLoadingStatus.value ==
    //                           Status.loading
    //                       ? const Padding(
    //                           padding: EdgeInsets.only(right: 10),
    //                           child: SizedBox(
    //                               height: 10,
    //                               width: 10,
    //                               child: CircularProgressIndicator(
    //                                 color: AppPalette.primaryColor,
    //                               )),
    //                         )
    //                       : const Padding(
    //                           padding: EdgeInsets.only(right: 10),
    //                           child: Icon(Icons.search, color: AppPalette.grey),
    //                         ),
    //               //const Icon(Icons.search, color: AppPalette.grey),
    //               contentPadding:
    //                   const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
    //         ));
    //   },
    //   controller: addressViewModel.searchController,
    //   hideOnEmpty: true,
    //   loadingBuilder: (ctx) => UtilWidgets.loadingWidget(),
    //   itemBuilder: (context, data) {
    //     return ListTile(
    //       title: Text(
    //         data.description,
    //         style: TypoBlack.black40014,
    //       ),
    //     );
    //   },
    //   onSelected: (x) async {
    //     addressViewModel.searchController.text = x.description;
    //     FocusScope.of(context).unfocus();
    //     addressViewModel.getLatAndLongFromSearchBar(x.description);
    //   },
    // );
  }
}
