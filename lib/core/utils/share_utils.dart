import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareAffirmation(BuildContext context, String text) async {
  final box = context.findRenderObject() as RenderBox?;
  Rect origin;
  if (box != null && box.hasSize && box.size.width > 0 && box.size.height > 0) {
    origin = box.localToGlobal(Offset.zero) & box.size;
  } else {
    final size = MediaQuery.sizeOf(context);
    origin = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 1,
      height: 1,
    );
  }

  await SharePlus.instance.share(
    ShareParams(text: text, sharePositionOrigin: origin),
  );
}
