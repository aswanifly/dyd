import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/spacing/static_spacing_helper.dart';
import '../../../core/config/theme/app_palette.dart';
import '../../../model/google-address-model/google_address_model.dart';
import '../view-model/address_view_model.dart';

class SearchAddressView extends StatelessWidget {
  const SearchAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    AddressViewModel addressViewModel = Get.find<AddressViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Address"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // search controller
            TextField(
              controller: addressViewModel.searchController,
              autofocus: false,
              onChanged: (value) {
                addressViewModel.observableSearchAddress(value);
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppPalette.white,
                  hintText: 'Search Location',
                  hintStyle: TypoBlack.black40012,
                  suffixIconConstraints:
                      const BoxConstraints(minHeight: 20, minWidth: 30),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.search, color: AppPalette.black),
                  ),
                  //const Icon(Icons.search, color: AppPalette.grey),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15)),
            ),
            //get current location
            buildGetCurrentLocationWidget(addressViewModel),
            const Divider(
              height: 1,
            ),
            //second part for saved or searched address
            buildSearchResultListCard(addressViewModel)
          ],
        ),
      ),
    );
  }

  //get current location with address details
  InkWell buildGetCurrentLocationWidget(AddressViewModel addressViewModel) {
    return InkWell(
      onTap: () => addressViewModel.getCurrentLocationWithAddressDetails(),
      child: Card(
        elevation: 0,
        color: AppPalette.white,
        shape: const RoundedRectangleBorder(),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                const Icon(
                  Icons.my_location,
                  color: AppPalette.blue,
                ),
                Spacing.horizontalSpace(10),
                Text(
                  "Use current location",
                  style: TypoPrimary.primary50014,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //second half for the address
  Expanded buildSearchResultListCard(AddressViewModel addressViewModel) {
    return Expanded(
      child: Obx(() {
        return addressViewModel.searchResultLoading.value == Status.loading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppPalette.primaryColor1,
                ),
              )
            : optionalWidgetForAddressResult(addressViewModel);
      }),
    );
  }

  //searched result list
  ListView buildSearchResultListView(AddressViewModel addressViewModel) {
    return ListView.builder(
      itemCount: addressViewModel.searchedAddressResultList.length,
      itemBuilder: (ctx, index) {
        GoogleMapAddressModel searchedResult =
            addressViewModel.searchedAddressResultList[index];
        return ListTile(
          onTap: () {
            // addressViewModel.searchController.text = searchedResult.description;
            addressViewModel
                .getLatAndLongFromSearchBar(searchedResult.description);
            Get.back();
          },
          leading: const Icon(Icons.location_on, color: AppPalette.black),
          title: Text(searchedResult.description),
        );
      },
    );
  }

  // conditionally returning widget
  Widget optionalWidgetForAddressResult(AddressViewModel addressViewModel) {
    //when the list is empty then showing saved address
    //else show searched address
    return Obx(
      () => addressViewModel.searchedAddressResultList.isEmpty
          ? const SizedBox()
          : buildSearchResultListView(addressViewModel),
    );
  }

  //saved address widget
  // Widget buildSavedAddressWidget(AddressViewModel addressViewModel) {
  //   return SizedBox(
  //     width: double.infinity,
  //     child: Card(
  //       elevation: 0,
  //       color: AppPalette.white,
  //       child: Padding(
  //         padding: const EdgeInsets.all(5.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Saved Address",
  //               style: TypoGrey.grey50015,
  //             ),
  //             //saved address list
  //             Expanded(
  //                 child: ListView.builder(
  //                     itemCount: addressViewModel.addressList.length,
  //                     itemBuilder: (ctx, index) {
  //                       AddAddressModel addressModel =
  //                           addressViewModel.addressList[index];
  //                       return ListTile(
  //                         leading: const Icon(Icons.circle,
  //                             color: AppPalette.grey, size: 10),
  //                         title: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             // Text(
  //                             //   addressModel.name!,
  //                             //   style: TypoBlack.black60016,
  //                             // ),
  //                             // Spacing.verticalSpace(5),
  //                             Text(
  //                               addressViewModel.addressModel(addressModel),
  //                               overflow: TextOverflow.ellipsis,
  //                               style: TypoGrey.grey40015,
  //                             ),
  //                             Spacing.verticalSpace(5),
  //                             Text(
  //                               addressModel.phoneNumber!,
  //                               overflow: TextOverflow.ellipsis,
  //                               style: TypoGrey.grey40015,
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     }))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
