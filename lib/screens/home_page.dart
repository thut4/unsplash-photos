import 'package:flutter/material.dart';
import 'package:flutter_application_photos/constant/app_color.dart';
import 'package:flutter_application_photos/controller/home_controller.dart';
import 'package:flutter_application_photos/widget/custom_gridview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Unsplash X',
            style: GoogleFonts.ubuntuMono(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 1,
              child: Container(
                  width: double.maxFinite,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  decoration: const BoxDecoration(color: AppColor.whiteColor),
                  child: ListView.builder(
                    itemCount: controller.orderList.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.selectedIndex.value = index;
                            controller.orderPhots(controller.orderList[index]);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 100,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(
                                index == 0 ? 5 : 15, 0, 5, 0),
                            decoration: BoxDecoration(
                                color: index == controller.selectedIndex.value
                                    ? AppColor.medGrey
                                    : AppColor.ligthGrey,
                                borderRadius: BorderRadius.circular(
                                    index == controller.selectedIndex.value
                                        ? 18
                                        : 15)),
                            child: Center(
                                child: Text(
                              controller.orderList[index],
                              style: GoogleFonts.ubuntu(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                color: index == controller.selectedIndex.value
                                    ? AppColor.whiteColor
                                    : AppColor.blackColor,
                              ),
                            )),
                          ),
                        ),
                      );
                    },
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 13,
              child: Obx(
                () => controller.photoList.isEmpty
                    ? Center(
                        child: LoadingAnimationWidget.flickr(
                          rightDotColor: AppColor.blackColor,
                          leftDotColor: AppColor.mainColor,
                          size: 30,
                        ),
                      )
                    : SizedBox(
                        height: 700,
                        child: CustomGridView(controller: controller)),
              ),
            ),
          ],
        ));
  }
}
