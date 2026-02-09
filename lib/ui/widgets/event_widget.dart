import 'package:evently_app/ui/utils/app_routes.dart';
import 'package:flutter/material.dart';
import '../model/event_dm.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class EventWidget extends StatelessWidget {
  final EventDM eventDM;
  const EventWidget({super.key, required this.eventDM});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, AppRoutes.eventDetails(eventDM));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .24,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                eventDM.categoryDM.imagePath,
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [buildDateContainer(), buildTitleContainer()],
            ),
          ],
        ),
      ),
    );
  }

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

  buildDateContainer() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.offWhite,
        ),
        child: Text(
          "${eventDM.dateTime.day} ${_getMonthAbbreviation(eventDM.dateTime.month)}", // Used the helper function
          textAlign: TextAlign.start,
          style: AppTextStyles.blue14SemiBold,
        ),
      ),
    );
  }

  buildTitleContainer() => Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppColors.offWhite,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            eventDM.title,
            style: AppTextStyles.blue14SemiBold,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Icon(eventDM.isFavorite ? Icons.favorite : Icons.favorite_border, color: AppColors.blue,),
      ],
    ),
  );
}
