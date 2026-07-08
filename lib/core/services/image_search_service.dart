import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Result of an image search — local file path + original URL.
class WallpaperImageResult {
  const WallpaperImageResult({required this.localPath, required this.sourceUrl, this.thumbnailUrl});

  final String localPath;
  final String sourceUrl;
  final String? thumbnailUrl;
}

/// Dart port of tools/image_search.py — searches DuckDuckGo images and caches locally.
class ImageSearchService {
  static const _userAgent =
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36';

  /// Search and download up to [count] wallpaper images for [query].
  Future<List<WallpaperImageResult>> searchWallpapers(String query, {int count = 12}) async {
    if (query.trim().isEmpty) return [];

    final urls = await _fetchImageUrls(query.trim(), count * 3);
    if (urls.isEmpty) return [];

    final dir = await _cacheDir(query);
    final results = <WallpaperImageResult>[];

    for (final url in urls) {
      if (results.length >= count) break;
      try {
        final saved = await _downloadImage(url, dir, results.length + 1);
        if (saved != null) {
          results.add(WallpaperImageResult(localPath: saved, sourceUrl: url, thumbnailUrl: url));
        }
      } catch (_) {
        continue;
      }
    }
    return results;
  }

  Future<List<String>> _fetchImageUrls(String query, int max) async {
    try {
      final vqd = await _fetchVqd(query);
      if (vqd == null) return _curatedFallback(query, max);

      final uri = Uri.parse(
        'https://duckduckgo.com/i.js'
        '?l=us&o=json&q=${Uri.encodeComponent(query)}&vqd=$vqd&f=,,,&p=1',
      );
      final resp = await http.get(uri, headers: {'User-Agent': _userAgent});
      if (resp.statusCode != 200) return _curatedFallback(query, max);

      final data = jsonDecode(resp.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      return results
          .map((r) => (r as Map<String, dynamic>)['image'] as String?)
          .whereType<String>()
          .take(max)
          .toList();
    } catch (_) {
      return _curatedFallback(query, max);
    }
  }

  Future<String?> _fetchVqd(String query) async {
    final resp = await http.get(
      Uri.parse('https://duckduckgo.com/?q=${Uri.encodeComponent(query)}'),
      headers: {'User-Agent': _userAgent},
    );
    final match = RegExp(r'vqd="([\d-]+)"').firstMatch(resp.body);
    return match?.group(1);
  }

  Future<String?> _downloadImage(String url, Directory dir, int index) async {
    final resp = await http.get(Uri.parse(url), headers: {'User-Agent': _userAgent});
    if (resp.statusCode != 200 || resp.bodyBytes.isEmpty) return null;

    final ext = _extFromContentType(resp.headers['content-type'], url);
    final file = File(p.join(dir.path, '${index.toString().padLeft(3, '0')}$ext'));
    await file.writeAsBytes(resp.bodyBytes);
    return file.path;
  }

  String _extFromContentType(String? contentType, String url) {
    final ct = contentType?.split(';').first.trim();
    return switch (ct) {
      'image/jpeg' => '.jpg',
      'image/png' => '.png',
      'image/webp' => '.webp',
      'image/gif' => '.gif',
      _ => p.extension(Uri.parse(url).path).isNotEmpty ? p.extension(Uri.parse(url).path) : '.jpg',
    };
  }

  Future<Directory> _cacheDir(String query) async {
    final base = await getTemporaryDirectory();
    final slug = query.toLowerCase().replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(RegExp(r'[\s-]+'), '_');
    final dir = Directory(p.join(base.path, 'wallpaper_search', slug));
    if (await dir.exists()) {
      await for (final f in dir.list()) {
        if (f is File) await f.delete();
      }
    } else {
      await dir.create(recursive: true);
    }
    return dir;
  }

  /// Curated Unsplash-style URLs when DDG is unavailable (offline dev / rate limits).
  List<String> _curatedFallback(String query, int max) {
    const pool = [
      'https://images.unsplash.com/photo-1419242902214-272b4217d9d8?w=1080',
      'https://images.unsplash.com/photo-1464821934021-9fdbba0a2d4f?w=1080',
      'https://images.unsplash.com/photo-1507400492013-162706c8c05e?w=1080',
      'https://images.unsplash.com/photo-1475274047050-1d0c09755e63?w=1080',
      'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1080',
      'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=1080',
      'https://images.unsplash.com/photo-1502134249126-9f3755a50d84?w=1080',
      'https://images.unsplash.com/photo-1444703686981-a3abbc4d4fe3?w=1080',
      'https://images.unsplash.com/photo-1536432596517-686b98d3c42e?w=1080',
      'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=1080',
      'https://images.unsplash.com/photo-1506318137071-a8e063b4bec0?w=1080',
      'https://images.unsplash.com/photo-1483728642387-6c3bdd6c93e5?w=1080',
    ];
  return List.generate(max.clamp(1, pool.length), (i) => pool[i % pool.length]);
  }
}
