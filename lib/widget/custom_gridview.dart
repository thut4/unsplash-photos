import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_photos/controller/home_controller.dart';
import 'package:flutter_application_photos/screens/detail_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.custom(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: const [
                QuiltedGridTile(2, 2),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 2),
              ]),
          childrenDelegate: SliverChildBuilderDelegate(
              childCount: controller.photoList.length, (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => DetailPage(index: index),
                    transition: Transition.cupertino,
                    curve: Curves.fastOutSlowIn);
              },
              child: Hero(
                tag: controller.photoList[index].id,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  child: CachedNetworkImage(
                    imageUrl: controller.photoList[index].urls.small,
                    placeholder: (context, url) =>
                        const CupertinoActivityIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_not_supported_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
