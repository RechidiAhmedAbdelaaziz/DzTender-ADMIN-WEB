extension MapFormatters on Map<String, dynamic> {
  Map<String, dynamic> removeNullValues() {
    return Map.fromEntries(entries.where((e) => e.value != null));
  }
}
