import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/common/widgets/custom_button.dart';

import '../../../../common/app_colors.dart';
import '../controllers/subscription_controller.dart';

class WalletView extends GetView<SubscriptionController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        // We use the real map directly — no sorting, no extra lists
        final walletMap = controller.walletTransactions;

        if (walletMap.isEmpty) {
          return Center(
            child: Text(
              "No transactions yet",
              style: TextStyle(fontSize: 18.sp),
            ),
          );
        }

        // Calculate balance directly from every transaction in the map
        double totalBalance = 0.0;
        walletMap.forEach((dateKey, transactions) {
          for (var t in transactions) {
            final amount = t['amount'] as double;
            totalBalance += t['type'] == 'credit' ? amount : -amount;
          }
        });

        return CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(
                expandedHeight: 450,
                totalBalance:
                    totalBalance, // We don't need to pass anything special anymore
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 0.h,
                        left: 22.w,
                        right: 22.w,
                        bottom: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.r),
                          topRight: Radius.circular(24.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Text(
                            'Quick Top-up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                              fontFamily: 'lato',
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _buildTopUpPackages(),
                          SizedBox(height: 40.h),
                          Text(
                            'Transaction History',
                            style: TextStyle(
                              color: AppColors.darkSlateBlue,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'lato',
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: _buildDirectTransactionHistory(walletMap),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTopUpPackages() {
    return Wrap(
      spacing: 16.w,
      runSpacing: 16.h,
      children: [
        _buildTopUpPackage(package: 10, discount: 0),
        _buildTopUpPackage(package: 25, bonus: 2.50, discount: 10),
        _buildTopUpPackage(package: 50, bonus: 7.50, discount: 15),
        _buildTopUpPackage(package: 100, bonus: 20, discount: 20),
      ],
    );
  }

  Widget _buildTopUpPackage({
    required double package,
    double? bonus,
    required int discount,
  }) {
    return Container(
      height: 241.h,
      width: 186.w,
      padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 23.w),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            package <= 24
                ? 'assets/svg/qt1.png'
                : package <= 49
                ? 'assets/svg/qt2.png'
                : package <= 99
                ? 'assets/svg/qt3.png'
                : 'assets/svg/qt4.png',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Package',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.white70,
              fontWeight: FontWeight.w400,
              fontFamily: 'lato',
            ),
          ),
          Text(
            '\$$package',
            style: TextStyle(
              fontSize: 35.sp,
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontFamily: 'lato',
            ),
          ),
          SizedBox(height: 8.h),
          if (bonus == null) ...[
            SizedBox(height: 12.h),
            Text(
              'Basic top-up',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
                fontFamily: 'lato',
              ),
            ),
          ],
          if (bonus != null)
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              decoration: BoxDecoration(
                color: AppColors.white50,
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColors.white, width: 1.5.w),
              ),
              child: Row(
                spacing: 8.w,
                children: [
                  SvgPicture.asset(
                    "assets/svg/gift.svg",
                    height: 16.h,
                    width: 16.w,
                  ),
                  SizedBox(
                    width: 81.w,
                    child: Center(
                      child: Text(
                        '+\$$bonus Bonus',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppColors.white,
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (discount > 0) ...[
            SizedBox(height: 25.h),
            Text(
              'Save $discount% extra',
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.white80,
                fontFamily: 'lato',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // This shows EVERYTHING directly from the map — no sorting, no changes
  Widget _buildDirectTransactionHistory(
    RxMap<String, List<Map<String, dynamic>>> walletMap,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: walletMap.length,
      itemBuilder: (context, index) {
        final dateKey = walletMap.keys.elementAt(index); // natural map order
        final transactions = walletMap[dateKey] ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Header
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: Text(
                dateKey,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
            // Transactions List
            ...transactions.map((t) {
              final amount = t['amount'] as double;
              final displayAmount = t['type'] == 'credit'
                  ? '+\$$amount'
                  : '-\$$amount';
              final time = t['createdAt'] as DateTime;
              final timeStr =
                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.history,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon
                    SvgPicture.asset(
                      t['type'] == 'credit'
                          ? 'assets/svg/topUp.svg'
                          : 'assets/svg/spend.svg',
                      height: 80.h,
                      width: 80.w,
                    ),
                    SizedBox(width: 5.w),
                    // Description and Amount
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 155.w,
                                child: Text(
                                  t['description'],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                t['description'].startsWith('Wallet')
                                    ? 'assets/svg/add.svg'
                                    : t['description'].startsWith('Voice')
                                    ? 'assets/svg/call.svg'
                                    : 'assets/svg/message.svg',
                                height: 25.h,
                                width: 25.w,
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            timeStr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Amount
                    Text(
                      displayAmount,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: t['type'] == 'credit'
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Divider(height: 1),
          ],
        );
      },
    );
  }
}

// Keep your original CustomSliverAppBarDelegate exactly as it was

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double totalBalance; // New parameter;

  const CustomSliverAppBarDelegate({
    required this.expandedHeight,
    required this.totalBalance,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final size = 300;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),
        Positioned(top: top, child: buildFloating(shrinkOffset)),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildBackground(double shrinkOffset) => Opacity(
    opacity: disappear(shrinkOffset),
    child: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        // Background Image or Color
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100.r),
              bottomRight: Radius.circular(100.r),
            ),
          ),
          child: SvgPicture.asset(
            'assets/svg/walletbg.svg', // Sample image for background
            fit: BoxFit.fill,
          ),
        ),
        // Top buttons (back + star)
        Positioned(
          top: 50.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle back action
                },
                child: Row(
                  spacing: 20.w,
                  children: [
                    Icon(Icons.arrow_back, size: 24.sp, color: Colors.white),
                    Text(
                      'My Wallet',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(top: 120.h, child: _buildWalletInfoCard(totalBalance)),
      ],
    ),
  );

  // Custom floating header, pinned at the top
  Widget buildFloating(double shrinkOffset) => SafeArea(
    child: SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(height: 50.h, width: 1.sw, color: Colors.transparent),
        ],
      ),
    ),
  );

  // Build the wallet info card widget
  Widget _buildWalletInfoCard(double balance) {
    return Container(
      width: 390.w,
      height: 250.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70.w,
                height: 70.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/svg/img.png',
                    ), // Background image (replace with your actual image)
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(28.r), // Rounded corners
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Text(
                  'Current Balance: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 19.sp,
                    fontFamily: 'lato',
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              '\$${balance.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 50.sp,
                fontFamily: 'lato',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available to spend',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.darkSlateBlue,
                    fontFamily: 'lato',
                  ),
                ),
                CustomButton(
                  height: 58.h,
                  width: 130.w,
                  label: 'Top Up',
                  onPressed: () {},
                  radius: 20.r,
                  gradient: LinearGradient(
                    colors: [AppColors.violet, AppColors.customDeepPurple],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Future<bool> _showConfirmationDialog(
    BuildContext context,
    String title,
  ) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              title,
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 18.sp,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.gray,
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: AppColors.category4,
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            backgroundColor: AppColors.barColor,
          ),
        ) ??
        false;
  }
}
