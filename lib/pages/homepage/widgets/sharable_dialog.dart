import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/extensions/avatar_url_doctor_ext.dart';
import 'package:doctopia_doctors/extensions/is_mobile_ext.dart';
import 'package:flutter/material.dart';
import 'package:proklinik_models/models/doctor.dart';

class SharableDialog extends StatelessWidget {
  const SharableDialog({super.key, required this.doctor});
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    //TODO: change locale internally (actions)
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Container(
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
              top: 57.5 * (context.isMobile ? (2 / 3) : 1),
              start: 60 * (context.isMobile ? (2 / 3) : 1),
              child: Container(
                width: 152 * (context.isMobile ? (2 / 3) : 1),
                height: 152 * (context.isMobile ? (2 / 3) : 1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(doctor.avatarUrl!),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
