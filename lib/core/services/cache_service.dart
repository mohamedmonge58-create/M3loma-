class CacheService {
  CacheService._();

  static final CacheService instance =
      CacheService._();

  final Map<String, dynamic> _cache = {};

  void save<T>(String key, T value) {
    _cache[key] = value;
  }

  T? get<T>(String key) {
    return _cache[key] as T?;
  }

  void remove(String key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }
}