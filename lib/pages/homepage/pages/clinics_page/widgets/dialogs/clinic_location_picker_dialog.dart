import 'package:doctopia_doctors/localization/loc_ext_fns.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic.dart';
import 'package:doctopia_doctors/models/clinic_response_model/clinic_location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ClinicLocationPickerDialog extends StatefulWidget {
  const ClinicLocationPickerDialog({
    super.key,
    required this.clinic,
  });
  final Clinic clinic;

  @override
  State<ClinicLocationPickerDialog> createState() =>
      _ClinicLocationPickerDialogState();
}

class _ClinicLocationPickerDialogState extends State<ClinicLocationPickerDialog>
    with OSMMixinObserver {
  late final MapController _controller;

  late bool _isInitial;

  GeoPoint? _location;

  @override
  void initState() {
    super.initState();
    _isInitial = widget.clinic.location == ClinicLocation.initial();
    _controller = MapController(
      initMapWithUserPosition: _isInitial ? UserTrackingOption() : null,
      initPosition: _isInitial
          ? null
          : GeoPoint(
              latitude: widget.clinic.location.lat,
              longitude: widget.clinic.location.lon,
            ),
    );
    _controller.addObserver(this);
  }

  @override
  void dispose() {
    _controller.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      title: Row(
        children: [
          Expanded(
            child: Text(context.loc.pickClinicLocation),
          ),
          IconButton.outlined(
            onPressed: () {
              Navigator.pop(context, null);
            },
            icon: const Icon(Icons.close),
          ),
          const SizedBox(width: 5),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            Positioned.fill(
              child: OSMFlutter(
                controller: _controller,
                osmOption: OSMOption(
                  userTrackingOption: UserTrackingOption(
                    enableTracking: true,
                    unFollowUser: false,
                  ),
                  showZoomController: true,
                  isPicker: false,
                  zoomOption: const ZoomOption(
                    initZoom: 14,
                    minZoomLevel: 2,
                    stepZoom: 1,
                  ),
                ),
                onMapMoved: (region) {
                  setState(() {
                    _location = region.center;
                  });
                },
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedCenterMarker(center: _location),
            ),
            PositionedDirectional(
              top: 10,
              height: 120,
              start: 10,
              width: 40,
              child: PointerInterceptor(
                intercepting: true,
                debug: kDebugMode,
                child: Column(
                  children: [
                    IconButton.filled(
                      onPressed: () async {
                        await _controller.zoomOut();
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    const SizedBox(height: 10),
                    IconButton.filled(
                      onPressed: () async {
                        await _controller.zoomIn();
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              bottom: 10,
              start: 10,
              width: 40,
              height: 40,
              child: PointerInterceptor(
                intercepting: true,
                debug: kDebugMode,
                child: IconButton.filled(
                  onPressed: () async {
                    final _userLocation = await _controller.myLocation();
                    await _controller.moveTo(
                      _userLocation,
                      animate: true,
                    );
                    setState(() {
                      _location = _userLocation;
                    });
                  },
                  icon: const Icon(Icons.location_on),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () async {
            final center = await _controller.centerMap;
            if (!context.mounted) return;
            Navigator.pop(context, center);
          },
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
      ],
    );
  }

  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      //TODO:
    }
  }
}
