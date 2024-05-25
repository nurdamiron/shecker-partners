import 'package:flutter/material.dart';

import 'package:shecker_partners/pages/dashboard/analytics_widget.dart';
import 'package:shecker_partners/pages/dashboard/channel_widget.dart';
import 'package:shecker_partners/pages/dashboard/grid_card.dart';
import 'package:shecker_partners/pages/dashboard/revenue_widget.dart';
import 'package:shecker_partners/pages/layout.dart';

class MainPage extends LayoutWidget {
  const MainPage({super.key});

  @override
  String breakTabTitle(BuildContext context) {
    // TODO: implement breakTabTitle
    return 'Main';
  }
  @override
  Widget contentDesktopWidget(BuildContext context) {
    return const Column(children: [
      GridCard(),
      SizedBox(
        height: 16,
      ),
      RevenueWidget(),
      SizedBox(
        height: 16,
      ),
      AnalyticsWidget(),
      SizedBox(
        height: 16,
      ),
      ChannelWidget()
    ]);
  }

}
