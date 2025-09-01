import 'dart:async';

import 'package:breach/core/utils/flushbar_notification.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtil {
  static Future<void> launchUrlLink(
    BuildContext context, {
    required String url,
    String? scheme,
    Map<String, dynamic>? queries,
  }) async {
    final uri = Uri(
      scheme: scheme,
      path: Uri.encodeFull(url),
      queryParameters: queries,
    );
    if (await canLaunchUrl(
      uri,
    )) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      if (!context.mounted) return;
      unawaited(
        FlushBarNotification.showError(
          context: context,
          message: 'Unable to launch $url',
        ),
      );
    }
  }
}
