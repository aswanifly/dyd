import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/widget/text-field-widget/search_text_field_widget.dart';
import 'package:dyd/feature/address/google-search-view/view-model/google_search_view_model.dart';
import 'package:dyd/model/google-address-model/google_address_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GoogleSearchView extends StatefulWidget {
  final String screenComingFrom;

  const GoogleSearchView({super.key, required this.screenComingFrom});

  @override
  State<GoogleSearchView> createState() => _GoogleSearchViewState();
}

class _GoogleSearchViewState extends State<GoogleSearchView> {
  final searchTxt = TextEditingController();

  @override
  void dispose() {
    searchTxt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GoogleSearchViewModel googleSearchViewModel =
        Get.put(GoogleSearchViewModel());
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Search Address"),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Spacing.verticalSpace(10),
                CSearchBar(
                  controller: searchTxt,
                  onChanged: (v) {
                    googleSearchViewModel.fObservableSearchAddress(v);
                  },
                  suffixIcon: IconButton(
                      onPressed: () {
                        searchTxt.clear();
                      },
                      icon: const Icon(Icons.close)),
                ),
                Spacing.verticalSpace(20),
                Expanded(
                    child: Obx(() =>
                        googleSearchViewModel.kSearchResultLoading.value ==
                                Status.loading
                            ? const CircularProgressIndicator()
                            : buildResultWidget(googleSearchViewModel)))
              ],
            ),
          ),
        ),
        Obx(() => googleSearchViewModel.kSearchAddressLatAndLongLoading.value ==
                Status.loading
            ? const CircularProgressIndicator()
            : const SizedBox())
      ],
    );
  }

  Widget buildResultWidget(GoogleSearchViewModel googleSearchViewModel) {
    return googleSearchViewModel.kSearchedAddressResultList.isEmpty
        ? Center(
            child: Text("No Address to show", style: TypoBlack.black50016),
          )
        : ListView.builder(
            itemCount: googleSearchViewModel.kSearchedAddressResultList.length,
            itemBuilder: (context, index) {
              GoogleMapAddressModel result =
                  googleSearchViewModel.kSearchedAddressResultList[index];
              return ListTile(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final (latitude, longitude) = await googleSearchViewModel
                      .fGetLatAndLongFromSearchBarAddress(result.description);

                  // addressViewModel.searchController.text = searchedResult.description;
                  // addressViewModel.getLatAndLongFromSearchBar(
                  //     searchedResult.description);
                  // Get.back();
                },
                leading: Icon(Icons.location_on, color: AppPalette.blue),
                title: Text(result.description),
              );
            });
  }
}
