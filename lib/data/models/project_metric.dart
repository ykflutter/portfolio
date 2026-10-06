/// One hard number from a project — "30%", "3", "< 2s".
///
/// This is the single most persuasive thing on a portfolio and the thing
/// most developers leave out. A project with no metric still renders fine;
/// it just carries less weight.
class ProjectMetric {
  final String value;
  final String label;

  const ProjectMetric({required this.value, required this.label});
}
