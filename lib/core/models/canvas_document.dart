import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum CanvasLayerType { text, shape, icon }

@immutable
class CanvasLayer {
  const CanvasLayer({
    required this.id,
    required this.type,
    this.text,
    this.fontStyle = 'playfair',
    this.fontSize = 28,
    this.color = Colors.white,
    this.italic = false,
    this.bold = false,
    this.icon,
    this.shape = 'circle',
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.rotation = 0.0,
  });

  final String id;
  final CanvasLayerType type;
  final String? text;
  final String fontStyle;
  final double fontSize;
  final Color color;
  final bool italic;
  final bool bold;
  final IconData? icon;
  final String shape;
  final Offset offset;
  final double scale;
  final double rotation;

  CanvasLayer copyWith({
    String? text,
    String? fontStyle,
    double? fontSize,
    Color? color,
    bool? italic,
    bool? bold,
    IconData? icon,
    String? shape,
    Offset? offset,
    double? scale,
    double? rotation,
  }) =>
      CanvasLayer(
        id: id,
        type: type,
        text: text ?? this.text,
        fontStyle: fontStyle ?? this.fontStyle,
        fontSize: fontSize ?? this.fontSize,
        color: color ?? this.color,
        italic: italic ?? this.italic,
        bold: bold ?? this.bold,
        icon: icon ?? this.icon,
        shape: shape ?? this.shape,
        offset: offset ?? this.offset,
        scale: scale ?? this.scale,
        rotation: rotation ?? this.rotation,
      );

  static CanvasLayer textLayer({
    required String text,
    String fontStyle = 'playfair',
    double fontSize = 32,
    Color color = Colors.white,
    bool italic = true,
  }) =>
      CanvasLayer(
        id: const Uuid().v4(),
        type: CanvasLayerType.text,
        text: text,
        fontStyle: fontStyle,
        fontSize: fontSize,
        color: color,
        italic: italic,
      );

  static CanvasLayer iconLayer(IconData icon, {Color color = Colors.white}) => CanvasLayer(
        id: const Uuid().v4(),
        type: CanvasLayerType.icon,
        icon: icon,
        color: color,
        scale: 1.5,
      );

  static CanvasLayer shapeLayer(String shape, {Color color = Colors.white54}) => CanvasLayer(
        id: const Uuid().v4(),
        type: CanvasLayerType.shape,
        shape: shape,
        color: color,
        scale: 2,
      );
}

@immutable
class CanvasDocument {
  const CanvasDocument({
    required this.affirmationText,
    this.backgroundImagePath,
    this.backgroundImageUrl,
    this.fontStyle = 'playfair',
    this.textAlign = TextAlign.center,
    this.textColor = Colors.white,
    this.overlayOpacity = 0.22,
    this.layers = const [],
    this.category = 'Inner Peace',
  });

  final String affirmationText;
  final String? backgroundImagePath;
  final String? backgroundImageUrl;
  final String fontStyle;
  final TextAlign textAlign;
  final Color textColor;
  final double overlayOpacity;
  final List<CanvasLayer> layers;
  final String category;

  CanvasDocument copyWith({
    String? affirmationText,
    String? backgroundImagePath,
    String? backgroundImageUrl,
    String? fontStyle,
    TextAlign? textAlign,
    Color? textColor,
    double? overlayOpacity,
    List<CanvasLayer>? layers,
    String? category,
  }) =>
      CanvasDocument(
        affirmationText: affirmationText ?? this.affirmationText,
        backgroundImagePath: backgroundImagePath ?? this.backgroundImagePath,
        backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
        fontStyle: fontStyle ?? this.fontStyle,
        textAlign: textAlign ?? this.textAlign,
        textColor: textColor ?? this.textColor,
        overlayOpacity: overlayOpacity ?? this.overlayOpacity,
        layers: layers ?? this.layers,
        category: category ?? this.category,
      );

  CanvasDocument addLayer(CanvasLayer layer) => copyWith(layers: [...layers, layer]);

  CanvasDocument updateLayer(String id, CanvasLayer updated) => copyWith(
        layers: layers.map((l) => l.id == id ? updated : l).toList(),
      );

  CanvasDocument removeLayer(String id) => copyWith(layers: layers.where((l) => l.id != id).toList());
}
