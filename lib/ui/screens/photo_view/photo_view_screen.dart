import 'package:cached_network_image/cached_network_image.dart';
import 'package:codetomobile/bloc/specific/router/router_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreenArgs extends RouteArgs {
  final String imageUrl;

  PhotoViewScreenArgs({required this.imageUrl});
}

class PhotoViewScreen extends StatelessWidget {
  final PhotoViewScreenArgs args;
  const PhotoViewScreen({required this.args, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.photo_view_app_bar_title,
        ),
      ),
      body: PhotoView(
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        imageProvider: CachedNetworkImageProvider(
          args.imageUrl,
        ),
        loadingBuilder:
            (BuildContext context, ImageChunkEvent? loadingProgress) {
          return const Center(child: const CircularProgressIndicator());
        },
      ),
    );
  }
}
