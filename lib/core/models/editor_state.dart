import 'package:desk_wellness/core/models/affirmation_draft.dart';
import 'package:desk_wellness/core/models/canvas_document.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editorDraftProvider = StateProvider<AffirmationDraft?>((ref) => null);
final canvasDocumentProvider = StateProvider<CanvasDocument?>((ref) => null);
