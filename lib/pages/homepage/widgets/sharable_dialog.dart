import 'dart:typed_data';

import 'package:doctopia_doctors/api/clinic_api/clinic_api.dart';
import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/components/central_loading.dart';
import 'package:doctopia_doctors/extensions/avatar_url_doctor_ext.dart';
import 'package:doctopia_doctors/extensions/is_mobile_ext.dart';
import 'package:doctopia_doctors/extensions/schedule_format_ext.dart';
import 'package:doctopia_doctors/functions/download_image.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:proklinik_models/models/doctor.dart';
import 'package:proklinik_models/proklinik_models.dart';
import 'package:screenshot/screenshot.dart';

const _doctorLink = 'https://proklinik.app/#/en/doc/';

class SharableDialog extends StatefulWidget {
  const SharableDialog({
    super.key,
    required this.doctor,
    required this.relativeFactor,
  });
  final Doctor doctor;
  final double relativeFactor;

  @override
  State<SharableDialog> createState() => _SharableDialogState();
}

class _SharableDialogState extends State<SharableDialog> {
  @protected
  late QrImage qrImage;

  Uint8List? qrImageBytes;

  late final HxClinic _clinicService;

  List<Clinic>? _clinics;

  late final ScreenshotController _screenshotController;

  @override
  void initState() {
    super.initState();
    _screenshotController = ScreenshotController();

    _clinicService = HxClinic();

    final qrCode = QrCode(
      8,
      QrErrorCorrectLevel.H,
    )..addData('$_doctorLink${widget.doctor.id}');

    qrImage = QrImage(qrCode);

    _translateQrToBytes();
    _fetchDoctorClinics();
  }

  Future<void> _translateQrToBytes() async {
    final data = await qrImage.toImageAsBytes(size: 128);
    setState(() {
      qrImageBytes = data?.buffer.asUint8List();
    });
  }

  Future<void> _fetchDoctorClinics() async {
    final data = await _clinicService.fetchDoctorClinics(widget.doctor.id);
    setState(() {
      _clinics = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO: change locale internally (actions)
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Screenshot(
        controller: _screenshotController,
        child: Container(
          width: 940 / (context.isMobile ? 3 : 2),
          height: 788 / (context.isMobile ? 3 : 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage(Assets.dialogBgEN),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              //# doctor avatar
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: 57.5 * widget.relativeFactor,
                start: 60 * widget.relativeFactor,
                child: Container(
                  width: 152 * widget.relativeFactor,
                  height: 152 * widget.relativeFactor,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.doctor.avatarUrl!),
                    ),
                  ),
                ),
              ),
              //# doctor qr code profile
              Positioned.directional(
                textDirection: TextDirection.ltr,
                bottom: 51 * widget.relativeFactor,
                end: 53 * widget.relativeFactor,
                child: Container(
                  width: 107 * widget.relativeFactor,
                  height: 109 * widget.relativeFactor,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    image: PrettyQrDecorationImage(
                      image: MemoryImage(qrImageBytes ?? Uint8List(0)),
                    ),
                  ),
                ),
              ),
              //# doctor spec
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: 230 * widget.relativeFactor,
                start: 40 * widget.relativeFactor,
                child: SizedBox(
                  height: 42.5 * widget.relativeFactor,
                  width: 195 * widget.relativeFactor,
                  child: Center(
                    child: Text(
                      widget.doctor.speciality_en,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20 * widget.relativeFactor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              //# doctor clinic address
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: (230 + (42.5 * 1.2)) * widget.relativeFactor,
                start: 40 * widget.relativeFactor,
                child: SizedBox(
                  height: 42.5 * widget.relativeFactor,
                  width: 195 * widget.relativeFactor,
                  child: Builder(
                    builder: (context) {
                      while (_clinics == null || _clinics!.isEmpty) {
                        return const SizedBox();
                      }
                      final _clinic = _clinics!.first;
                      return Text(
                        _clinic.destination.addressEn,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16 * widget.relativeFactor,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    },
                  ),
                ),
              ),
              //# doctor clinic address
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: (230 + (42.5 * 2.3)) * widget.relativeFactor,
                start: 40 * widget.relativeFactor,
                child: SizedBox(
                  height: 42.5 * widget.relativeFactor,
                  width: 195 * widget.relativeFactor,
                  child: Builder(
                    builder: (context) {
                      while (_clinics == null || _clinics!.isEmpty) {
                        return const SizedBox();
                      }
                      final _clinic = _clinics!.first;
                      return Text(
                        _clinic.mobile,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14 * widget.relativeFactor,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    },
                  ),
                ),
              ),
              //# doctor name
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: 57.5 * widget.relativeFactor,
                start: 241 * widget.relativeFactor,
                child: SizedBox(
                  height: 42.5 * widget.relativeFactor,
                  // width: 195 * widget.relativeFactor,
                  child: Center(
                    child: Text(
                      'Dr. ${widget.doctor.name_en}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22 * widget.relativeFactor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              //# doctor title text
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: (57.5 + 42.5) * widget.relativeFactor,
                start: 241 * widget.relativeFactor,
                child: SizedBox(
                  height: (42.5 * 1.2) * widget.relativeFactor,
                  width: 165 * widget.relativeFactor,
                  child: Center(
                    child: Text(
                      widget.doctor.title_en,
                      textAlign: TextAlign.center,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 12 * widget.relativeFactor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              //# doctor clinic schedule
              Positioned.directional(
                textDirection: TextDirection.ltr,
                top: (57.5 + 42.5 + (42.5 * 1.2)) * widget.relativeFactor,
                start: 220 * widget.relativeFactor,
                child: SizedBox(
                  height: (42.5 * 1.6) * widget.relativeFactor,
                  width: 200 * widget.relativeFactor,
                  child: Center(
                    child: Builder(
                      builder: (context) {
                        while (_clinics == null || _clinics!.isEmpty) {
                          return const SizedBox();
                        }
                        final _clinic = _clinics!.first;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._clinic.schedule.map<Widget>((s) {
                              if (!s.available) {
                                return const SizedBox();
                              }
                              return Text(
                                s.toFormattedScheduleString(context),
                                style: TextStyle(
                                  fontSize: 12 * widget.relativeFactor,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.start,
                              );
                            }).toList(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      actions: [
        ElevatedButton.icon(
          onPressed: () async {
            late BuildContext _loadingContext;
            final data = await _screenshotController.capture();

            if (data != null) {
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) {
                    _loadingContext = context;
                    return const CentralLoading();
                  },
                );
              }
              await ImageDownloader.download(
                uInt8List: data,
                name: widget.doctor.name_en,
              );
              if (_loadingContext.mounted) {
                Navigator.pop(_loadingContext);
              }
            }
          },
          label: const Text('Download'),
        ),
      ],
    );
  }
}
