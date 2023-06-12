import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../export_files.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
    required this.currentDate,
  });

  final String currentDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/location.svg'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<String?>(
                future: getUserCity(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      AppString.loading,
                      style: AppTextStyles.headline1,
                    );
                  } else {
                    return Text(
                      snapshot.data!,
                      style: AppTextStyles.headline1,
                    );
                  }
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            currentDate,
            style: AppTextStyles.subHead,
          ),
        ),
      ],
    );
  }
}
