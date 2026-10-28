class SkillGroup {
  final String title;
  final List<String> skills;

  const SkillGroup({required this.title, required this.skills});
}

/// A highlight on the Skills page. [route] makes the card a link.
class Achievement {
  final String title;
  final String description;
  final String? route;

  const Achievement({
    required this.title,
    required this.description,
    this.route,
  });
}

/// A degree or a certificate — both render as the same card.
class Credential {
  final String kind;
  final String title;
  final String institution;
  final String period;

  const Credential({
    required this.kind,
    required this.title,
    required this.institution,
    required this.period,
  });
}
