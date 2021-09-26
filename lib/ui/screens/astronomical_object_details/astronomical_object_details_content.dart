import 'package:codetomobile/data/models/astronomical_object.dart';
import 'package:codetomobile/shared/view/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildContent(
    BuildContext context, AstronomicalObject astronomicalObject) {
  return SafeArea(
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: Dimensions.basic,
        right: Dimensions.basic,
        bottom: Dimensions.large,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, astronomicalObject.title!),
          if (astronomicalObject.date?.isNotEmpty ?? false)
            _buildDate(context, astronomicalObject.date!),
          if (astronomicalObject.description?.isNotEmpty ?? false)
            _buildAbout(context, astronomicalObject.description!),
          if (astronomicalObject.apodSite?.isNotEmpty ?? false)
            _buildWebsite(context, astronomicalObject.apodSite!),
          if (astronomicalObject.copyright?.isNotEmpty ?? false)
            _buildAuthors(context, astronomicalObject.copyright!),
        ],
      ),
    ),
  );
}

Widget _buildTitle(BuildContext context, String title) {
  return Text(
    title,
    style: Theme.of(context).textTheme.headline6,
  );
}

Widget _buildDate(BuildContext context, String date) {
  return Column(
    children: [
      const SizedBox(height: Dimensions.small),
      Text(
        date,
        style: Theme.of(context).textTheme.caption,
      ),
    ],
  );
}

Widget _buildAbout(BuildContext context, String about) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(
        height: Dimensions.huge,
      ),
      Text(
        AppLocalizations.of(context)!.astronomical_object_details_about,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      const SizedBox(height: Dimensions.small),
      Text(
        about,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ],
  );
}

Widget _buildWebsite(BuildContext context, String website) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(
        height: Dimensions.huge,
      ),
      Text(
        AppLocalizations.of(context)!.astronomical_object_details_website,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      const SizedBox(height: Dimensions.small),
      Text(
        website,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ],
  );
}

Widget _buildAuthors(BuildContext context, String copyright) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Divider(
        height: Dimensions.huge,
      ),
      Text(
        AppLocalizations.of(context)!.astronomical_object_details_authors,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      const SizedBox(height: Dimensions.small),
      Text(
        copyright,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ],
  );
}
