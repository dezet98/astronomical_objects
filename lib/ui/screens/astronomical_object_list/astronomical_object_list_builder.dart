import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/widgets.dart';

import 'astronomical_object_list_tile.dart';

Widget buildGrid(BuildContext context,
    List<AstronomicalObject> astronomicalObjects, Orientation orientation) {
  return SliverPadding(
    padding: const EdgeInsets.all(Dimensions.verySmall),
    sliver: SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return buildGridTile(context, astronomicalObjects[index]);
        },
        childCount: astronomicalObjects.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        mainAxisSpacing: Dimensions.small,
        crossAxisSpacing: Dimensions.verySmall,
        childAspectRatio: orientation == Orientation.portrait ? 0.75 : 1,
      ),
    ),
  );
}
