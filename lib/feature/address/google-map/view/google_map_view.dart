import 'package:dyd/feature/address/view-model/address_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CGoogleMap extends StatelessWidget {
  const CGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    AddressViewModel addressViewModel = Get.find();
    return Obx(() => GoogleMap(
          buildingsEnabled: true,
          mapType: addressViewModel.kMapType.isFalse
              ? MapType.satellite
              : MapType.terrain,
          indoorViewEnabled: false,
          trafficEnabled: false,
          myLocationEnabled: false,
          initialCameraPosition: CameraPosition(
            target: addressViewModel.markerPosition.value,
            zoom: 20,
          ),
          onMapCreated: addressViewModel.onGoogleMapCreate,
          onTap: addressViewModel.onMapPressed,
          markers: {
            Marker(
              markerId: const MarkerId("current_marker"),
              position: addressViewModel.markerPosition.value,
              draggable: true,
              onDragEnd: (value) {},
            ),
          },
          // onCameraMove: (cameraPosition) {
          //   addressViewModel.markerPosition(cameraPosition.target);
          //   addressViewModel.getAddressOnMapDrag(cameraPosition.target);
          // },
        ));
  }
}
