import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/assets/assets.gen.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/preferences/shared_preferences_utils.dart';
import 'package:rebuild_bank_sampah/presentation/login/widgets/input_widget.dart';
import 'package:rebuild_bank_sampah/presentation/profile/controllers/profile_controller.dart';
import 'package:rebuild_bank_sampah/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.LABEL_PROFILE,
          style: Get.textTheme.titleLarge!.copyWith(fontSize: AppSizes.s18),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.colorBaseBlack,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.colorBaseWhite, width: AppSizes.s2),
              borderRadius: BorderRadius.circular(100),
              // color: AppColors.colorBasePrimary,
              image: DecorationImage(
                image: AssetImage(Assets.images.avatarSuperAdmin.path),
              ),
            ),
          ),
          Column(
            children: [
              Obx(() {
                if (controller.profile.value != null) {
                  return InputWidget(
                    label: AppConstants.LABEL_NAME,
                    controller: TextEditingController(
                        text: controller.profile.value!.name),
                    readOnly: true,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
              AppSizes.s20.height,
              Obx(() {
                if (controller.profile.value != null) {
                  return InputWidget(
                    label: AppConstants.LABEL_PHONE_NUMBER,
                    controller: TextEditingController(
                        text: controller.profile.value!.telp),
                    readOnly: true,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
              AppSizes.s20.height,
              Obx(() {
                if (controller.profile.value != null) {
                  return InputWidget(
                    label: AppConstants.LABEL_ADDRESS,
                    controller: TextEditingController(
                        text: controller.profile.value!.address),
                    readOnly: true,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
              AppSizes.s44.height,
              Button.outlined(
                onPressed: () async {
                  await controller.removeItem();
                  await SharedPreferencesUtils.deleteAuthToken();
                  Get.offAllNamed(AppRoutes.login);
                },
                label: AppConstants.LABEL_LOGOUT,
                color: AppColors.colorBaseError,
                textColor: AppColors.colorBaseWhite,
              ),
              AppSizes.s20.height,
            ],
          ).paddingSymmetric(horizontal: AppSizes.s24, vertical: AppSizes.s10)
        ],
      ),
    );
  }

  void modalPicture(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.colorBaseWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateBottomSheet) {
            return FractionallySizedBox(
              heightFactor: 0.35,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.s24, vertical: AppSizes.s16),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 8,
                      height: AppSizes.s8,
                      decoration: const BoxDecoration(
                          color: AppColors.colorNeutrals300,
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                    ),
                    SizedBox(
                      height: AppSizes.s30,
                    ),
                    Text(
                      'edit_photo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    SizedBox(
                      height: AppSizes.s35,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                              // final ImagePicker _picker = ImagePicker();

                              // // Capture a photo
                              // final XFile? photo = await _picker.pickImage(
                              //     source: ImageSource.camera);
                              // if (photo != null) {
                              //   setState(() {
                              //     File retImage = File(photo.path);
                              //     _tempPhoto = retImage;
                              //   });
                              // }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: AppSizes.s10,
                                ),
                                Text(
                                  'take_photo',
                                ),
                                SizedBox(
                                  height: AppSizes.s10,
                                ),
                                const Divider(
                                  color: AppColors.colorNeutrals300,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.pop(context);

                              // Pick an image
                              // FilePickerResult? result =
                              //     await FilePicker.platform.pickFiles(
                              //   type: FileType.image,
                              // );
                              // if (result != null) {
                              //   setState(() {
                              //     _tempPhoto = File(result.files.single.path!);
                              //   });
                              // }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: AppSizes.s10,
                                ),
                                Text(
                                  'choose_gallery',
                                ),
                                SizedBox(
                                  height: AppSizes.s10,
                                ),
                                const Divider(
                                  color: AppColors.colorNeutrals300,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
