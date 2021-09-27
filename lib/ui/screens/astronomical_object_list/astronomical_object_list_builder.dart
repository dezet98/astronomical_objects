import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/widgets.dart';

import 'astronomical_object_list_tile.dart';

Widget buildGrid(
    BuildContext context, List<AstronomicalObject> astronomicalObjects) {
  return SliverPadding(
    padding: const EdgeInsets.all(Dimensions.verySmall),
    sliver: SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return buildGridTile(context, astronomicalObjects[index]);
        },
        childCount: astronomicalObjects.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.small,
        crossAxisSpacing: Dimensions.verySmall,
        childAspectRatio: 0.75,
      ),
    ),
  );
}
