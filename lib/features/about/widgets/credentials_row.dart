import 'package:flutter/material.dart';

import '../../../data/content/experience_data.dart';
import '../../../shared/layout/responsive_grid.dart';
import 'credential_card.dart';

/// Degree and certification, side by side where there is room.
class CredentialsRow extends StatelessWidget {
  const CredentialsRow({super.key});

  @override
  Widget build(BuildContext context) {
    const items = ExperienceData.credentials;

    return ResponsiveGrid(
      itemCount: items.length,
      columnsFor: ResponsiveGrid.twoColumns,
      itemBuilder: (context, i, _) => CredentialCard(credential: items[i]),
    );
  }
}
