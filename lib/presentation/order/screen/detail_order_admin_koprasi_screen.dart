import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rebuild_bank_sampah/core/component/button_component.dart';
import 'package:rebuild_bank_sampah/core/resources/constans/app_constants.dart';
import 'package:rebuild_bank_sampah/core/styles/app_colors.dart';
import 'package:rebuild_bank_sampah/core/styles/app_sizes.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/date_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/int_ext.dart';
import 'package:rebuild_bank_sampah/core/utils/extensions/sized_box_ext.dart';
import 'package:rebuild_bank_sampah/presentation/order/controllers/order_admin_koprasi_controller.dart';
import 'package:rebuild_bank_sampah/presentation/order/screen/loading_order_screen.dart';
import 'package:rebuild_bank_sampah/presentation/order/widgets/card_order_tile_widget.dart';
import 'package:rebuild_bank_sampah/services/order/model/request/post_update_status_request.dart';
import 'package:rebuild_bank_sampah/services/order/model/response/get_order_admin_response.dart';

class DetailOrderAdminKoprasiScreen extends StatelessWidget {
  final OrderAdmin data;
  const DetailOrderAdminKoprasiScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    OrderAdminKoprasiController controller =
        Get.put(OrderAdminKoprasiController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.ACTION_ORDER,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dipesan pada Diajukan pada ${data.createdAt.toFormattedDateDayTimeString()}',
            style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSizes.s10, color: AppColors.colorNeutrals500),
          ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kode Pesanan',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
              Text(
                data.orderCode,
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s16),
              ),
            ],
          ),
          AppSizes.s20.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Text(
                data.user.profile.name,
                style:
                    Get.textTheme.titleSmall!.copyWith(fontSize: AppSizes.s14),
              ),
            ],
          ),
          AppSizes.s5.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'No Telp',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Text(
                data.user.profile.telp,
                style:
                    Get.textTheme.titleSmall!.copyWith(fontSize: AppSizes.s14),
              ),
            ],
          ),
          AppSizes.s5.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Alamat',
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontSize: AppSizes.s14),
              ),
              Container(
                width: 200,
                padding: AppSizes.allPadding(0),
                child: Text(
                  data.user.profile.address,
                  textAlign: TextAlign.right,
                  style: Get.textTheme.titleSmall!
                      .copyWith(fontSize: AppSizes.s14),
                ),
              )
            ],
          ),
          AppSizes.s20.height,
          Expanded(
            child: ListView.builder(
              itemCount: data.transactionProduct.length,
              itemBuilder: (BuildContext context, index) {
                var datas = data.transactionProduct[index];
                return CardOrderTileWidget(
                  imageUrl: datas.product.image,
                  title: datas.product.name,
                  quantity: datas.quantity,
                  price: datas.product.price.currencyFormatRp,
                  onTap: () {
                    //controller.changeStatus(index);
                  },
                  isActive: false,
                  showCheckout: true,
                  showOrder: false,
                );
              },
            ),
          )
        ],
      ).paddingAll(AppSizes.s20),
      bottomNavigationBar: Container(
        width: double.infinity,
        //height: 200,
        // height: 100,
        padding: const EdgeInsets.all(16.0),
        //color: AppColors.colorBaseWhite,
        decoration: BoxDecoration(
          color: AppColors.colorBaseWhite,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              blurRadius: 12.0,
              spreadRadius: 4,
              color: AppColors.colorSecondary500.withOpacity(0.4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Pesanan :',
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontSize: AppSizes.s15,
                  ),
                ),
                AppSizes.s20.width,
                Text(
                  data.totalPrice.currencyFormatRp,
                  style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSizes.s17,
                      color: AppColors.colorBasePrimary),
                ),
              ],
            ),
            if (data.status == 'PENDING') ...[
              AppSizes.s20.height,
              Button.filled(
                onPressed: () async {
                  final datum = PostUpdateStatusRequest(
                    transactionId: data.id,
                    status: 'DONE',
                  );
                  await controller.postUpdateStatusOrder(context, datum);
                },
                label: 'Setujui Pesanan',
                borderRadius: AppSizes.s4,
              ),
              AppSizes.s12.height,
              Button.outlined(
                colorBorder: AppColors.colorError300,
                onPressed: () async {
                  final datum = PostUpdateStatusRequest(
                    transactionId: data.id,
                    status: "CANCEL",
                  );
                  await controller.postUpdateStatusOrder(context, datum);
                },
                label: 'Batalkan Pesanan',
                textColor: AppColors.colorError300,
                borderRadius: AppSizes.s4,
              )
            ],
          ],
        ),
      ),
    );
  }
}
