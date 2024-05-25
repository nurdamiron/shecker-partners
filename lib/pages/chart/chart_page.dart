import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flareline_uikit/components/card/common_card.dart';
import 'package:shecker_partners/components/charts/bar_chart.dart';
import 'package:shecker_partners/components/charts/circular_chart.dart';
import 'package:shecker_partners/components/charts/line_chart.dart';
import 'package:shecker_partners/pages/layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChartPage extends LayoutWidget {
  const ChartPage({super.key});

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: CommonCard(
            child: LineChartWidget(),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
            height: 350,
            child: CommonCard(child: BarChartWidget())),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
            height: 350,
            child: CommonCard(
              child: CircularhartWidget(),
            ))
      ],
    );
  }

  @override
  String breakTabTitle(BuildContext context) {
    return AppLocalizations.of(context)!.chartPageTitle;
  }
}
