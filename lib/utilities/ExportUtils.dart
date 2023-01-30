import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void copyToClipboard(BuildContext context, String content) async {
  await Clipboard.setData(ClipboardData(text: '#$content'));
  log("copied to clipboard $content");
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("copied to clipboard")));
}
