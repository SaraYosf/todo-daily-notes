import 'package:flutter/material.dart';

import '../../shared/components/sittings_text_field.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SittingTextField(txt: "English",head:"Language" ),
          SittingTextField(txt: "light",head: "lightness",)
        ],
      ),
    );
  }
}
