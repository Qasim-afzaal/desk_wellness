import 'package:desk_wellness/core/models/affirmation_template.dart';
import 'package:flutter/material.dart';

@immutable
class AffirmationDraft {
  const AffirmationDraft({
    required this.text,
    required this.template,
    this.fontStyle = 'calm',
    this.textAlign = 'center',
    this.exportType = 'wallpaper',
    this.backgroundOverride,
    this.backgroundImagePath,
    this.backgroundImageUrl,
  });

  final String text;
  final AffirmationTemplate template;
  final String fontStyle;
  final String textAlign;
  final String exportType;
  final Color? backgroundOverride;
  final String? backgroundImagePath;
  final String? backgroundImageUrl;

  Color get background => backgroundOverride ?? template.background;

  AffirmationDraft copyWith({
    String? text,
    AffirmationTemplate? template,
    String? fontStyle,
    String? textAlign,
    String? exportType,
    Color? backgroundOverride,
    String? backgroundImagePath,
    String? backgroundImageUrl,
  }) =>
      AffirmationDraft(
        text: text ?? this.text,
        template: template ?? this.template,
        fontStyle: fontStyle ?? this.fontStyle,
        textAlign: textAlign ?? this.textAlign,
        exportType: exportType ?? this.exportType,
        backgroundOverride: backgroundOverride ?? this.backgroundOverride,
        backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
        backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
      );
}
