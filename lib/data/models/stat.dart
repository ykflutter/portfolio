/// A number tile on the home page.
class Stat {
  final String value;
  final String label;

  /// Where tapping it goes. Null means it isn't a link.
  final String? route;

  const Stat({required this.value, required this.label, this.route});
}
