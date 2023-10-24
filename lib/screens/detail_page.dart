import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_photos/constant/app_color.dart';
import 'package:flutter_application_photos/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Hero(
        tag: controller.photoList[index].id,
        child: CachedNetworkImage(
          imageUrl: controller.photoList[index].urls.regular,
          imageBuilder: (context, imageProvider) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image(image: imageProvider, fit: BoxFit.cover))),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.blackColor,
                        Colors.transparent,
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    child: Text(
                      DateFormat.yMMMEd()
                          .format(controller.photoList[index].createdAt),
                      // controller.photoList[index].createdAt.toIso8601String(),
                      style: GoogleFonts.ubuntuMono(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor),
                    ))
              ],
            );
          },
          placeholder: (context, url) => Center(
            child: LoadingAnimationWidget.flickr(
              rightDotColor: AppColor.blackColor,
              leftDotColor: AppColor.mainColor,
              size: 35,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_rounded,
              color: AppColor.medGrey),
        ),
      ),
    ));
  }
}
