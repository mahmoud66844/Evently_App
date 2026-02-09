import 'package:evently_app/firebase_utils/firestore_utility.dart';
import 'package:evently_app/ui/utils/app_assets.dart';
import 'package:evently_app/ui/utils/app_dialogs.dart';
import 'package:evently_app/ui/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../model/event_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.event});
  final EventDM event;

  String _getMonthAbbreviation(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    if (month >= 1 && month <= 12) {
      return months[month - 1];
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.offWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: const Icon(Icons.arrow_back, color: AppColors.blue,)
        ),
        title: const Text("Event details", style: AppTextStyles.blue18Medium,),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, AppRoutes.editEvent(event));
            },
            child: SvgPicture.asset(AppAssets.icAllSvg)
          ),
          const SizedBox(width: 8,),
          InkWell(
            onTap: () {
              showMessage(context, "Are you sure you want to delete this event?",
                posText: "Yes",
                negText: "No",
                posAction: () {
                  deleteEventFromFirestore(event.id ?? "");
                  Navigator.pop(context); // for details screen
                }
              );
            },
            child: SvgPicture.asset(AppAssets.icCalendarSvg)
          ),
          const SizedBox(width: 16,),
        ],
      ),
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                  child: Image.asset(event.categoryDM.imagePath, height: MediaQuery.of(context).size.height * .2,fit: BoxFit.fill,)
              ),
              const SizedBox(height: 16,),
              Text(event.title, style: AppTextStyles.black20SemiBold,),
              const SizedBox(height: 12,),
              Text(event.description, style: AppTextStyles.grey12Regular,),
              const SizedBox(height: 24,),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, color: AppColors.blue,),
                        const SizedBox(width: 8,),
                        Text("${event.dateTime.day} ${_getMonthAbbreviation(event.dateTime.month)}", style: AppTextStyles.black20SemiBold,),
                      ], 
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        const Icon(Icons.access_time_filled, color: AppColors.blue,),
                        const SizedBox(width: 8,),
                        Text(DateFormat.jm().format(event.dateTime), style: AppTextStyles.black20SemiBold,),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
