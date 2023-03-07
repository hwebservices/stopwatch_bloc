import 'package:stopwatch/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_avatar.dart';
import '../../widgets/custom_scaffold.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: "Statistics",
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: UserAvatar(),
        ),
      ),
      body: Column(),
    );
  }
}
