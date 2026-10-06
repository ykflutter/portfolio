class SkillGroup {
  final String title;
  final List<String> skills;

  const SkillGroup({required this.title, required this.skills});
}

/// A highlight / achievement line on the skills page.
class Achievement {
  final String title;
  final String description;

  const Achievement({required this.title, required this.description});
}

class Education {
  final String degree;
  final String institution;
  final String year;

  const Education({
    required this.degree,
    required this.institution,
    required this.year,
  });
}
