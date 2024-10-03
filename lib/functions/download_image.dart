import 'dart:typed_data';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/painting.dart';

enum ImageType {
  /// Animated Portable Network Graphics (APNG)
  apng('image/apng'),

  /// AV1 Image File Format (AVIF)
  avif('image/avif'),

  /// Graphics Interchange Format (GIF)
  gif('image/gif'),

  /// Joint Photographic Expert Group image (JPEG)
  jpeg('image/jpeg'),

  /// Portable Network Graphics (PNG)
  png('image/png'),

  /// Scalable Vector Graphics (SVG)
  svg('image/svg+xml'),

  /// Web Picture format (WEBP)
  webp('image/webp');

  const ImageType(this.format);

  final String format;
}

class ImageDownloader {
  const ImageDownloader();

  static Future<void> download({
    required Uint8List uInt8List,
    double imageQuality = 1.00,
    String? name,
    ImageType imageType = ImageType.png,
  }) async {
    final image = await decodeImageFromList(uInt8List);

    final html.CanvasElement canvas = html.CanvasElement(
      height: image.height,
      width: image.width,
    );

    final ctx = canvas.context2D;

    final List<String> binaryString = [];

    for (final imageCharCode in uInt8List) {
      final charCodeString = String.fromCharCode(imageCharCode);
      binaryString.add(charCodeString);
    }
    final data = binaryString.join();

    final base64 = html.window.btoa(data);

    final img = html.ImageElement();

    img.src = "data:${imageType.format};base64,$base64";

    final html.ElementStream<html.Event> loadStream = img.onLoad;

    loadStream.listen((event) {
      ctx.drawImage(img, 0, 0);
      final dataUrl = canvas.toDataUrl(imageType.format, imageQuality);
      final html.AnchorElement anchorElement =
          html.AnchorElement(href: dataUrl);
      anchorElement.download = name ?? dataUrl;
      anchorElement.click();
    });
  }
}
