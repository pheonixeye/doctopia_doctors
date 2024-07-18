// import 'package:doctopia_doctors/api/scrapper_api/scrapper_api.dart';
import 'package:doctopia_doctors/assets/assets.dart';
import 'package:doctopia_doctors/extensions/is_mobile_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(Assets.bg),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.5),
                BlendMode.modulate,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.sizeOf(context).height / 2,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: SvgPicture.asset(
                  Assets.construction,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "This Page is Under Construction.",
                  style: TextStyle(
                    fontSize: context.isMobile ? 18 : 36,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "Sorry For Any Inconvenience, But This Page is Still Being Built And Tested. In The Mean Time, You Can Still Browse Other Pages.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              // ElevatedButton.icon(
              //   onPressed: () async {
              //     final HxScrapper _s = HxScrapper();
              //     await _s.init();
              //   },
              //   label: const Text("test it"),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
