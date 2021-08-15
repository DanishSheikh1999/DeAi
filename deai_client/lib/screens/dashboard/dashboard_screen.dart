
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../responsive.dart';

import 'components/my_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              
        child: Column(
          children: [
            SizedBox(height: defaultPadding),
            MyFiles()
          ],
        ),
      ),
    );
  }
}
