abstract final class AffirmationCategories {
  static const feedTabs = ['all', 'calm', 'manifest', 'abundance', 'love', 'focus', 'bold'];

  static String label(String id) => switch (id) {
        'all' => 'All',
        'calm' => 'Calm',
        'manifest' => 'Manifest',
        'abundance' => 'Abundance',
        'love' => 'Love',
        'focus' => 'Focus',
        'bold' => 'Bold',
        'favorites' => 'Favorites',
        _ => id[0].toUpperCase() + id.substring(1),
      };
}
