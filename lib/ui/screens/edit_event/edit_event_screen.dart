import 'package:evently_app/firebase_utils/firestore_utility.dart';
import 'package:evently_app/ui/utils/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/event_dm.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/evently_button.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key, required this.event});
  final EventDM event;

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.event.title;
    descriptionController.text = widget.event.description;
    selectedDate = widget.event.dateTime;
    selectedTime = TimeOfDay.fromDateTime(widget.event.dateTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
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
        title: const Text("Edit event", style: AppTextStyles.blue18Medium,),
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
                  child: Image.asset(widget.event.categoryDM.imagePath, height: MediaQuery.of(context).size.height * .2,fit: BoxFit.fill,)
              ),
              const SizedBox(height: 16,),
              const Text("Title", style: AppTextStyles.black20SemiBold,),
              const SizedBox(height: 8,),
              AppTextField(
                hint: "",
                controller: titleController,
                 minLines: 4, isPassword: false,
              ),
              const SizedBox(height: 16,),
              const Text("Description", style: AppTextStyles.black20SemiBold,),
              const SizedBox(height: 8,),
              AppTextField(
                hint: "",
                controller: descriptionController,
                minLines: 4, isPassword: false,
              ),
              const SizedBox(height: 24,),
              InkWell(
                onTap: () => _selectDate(context),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: AppColors.blue,),
                    const SizedBox(width: 8,),
                    const Text("Event Date", style: AppTextStyles.black20SemiBold,),
                    const Spacer(),
                    Text(DateFormat.yMMMd().format(selectedDate), style: AppTextStyles.blue14Regular,)
                  ],
                ),
              ),
              const SizedBox(height: 16,),
              InkWell(
                onTap: () => _selectTime(context),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_filled, color: AppColors.blue,),
                    const SizedBox(width: 8,),
                    const Text("Event Time", style: AppTextStyles.black14Medium,),
                    const Spacer(),
                    Text(selectedTime.format(context), style: AppTextStyles.blue14Regular,)
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .1,),
              EventlyButton(text: "Update event", onPress: (){
                updateEvent();
              })
            ],
          ),
        ),
      ),
    );
  }

  void updateEvent() {
    showLoading(context);
    updateEventInFirestore(EventDM(
      id: widget.event.id,
      title: titleController.text,
      description: descriptionController.text,
      categoryDM: widget.event.categoryDM,
      ownerId: widget.event.ownerId,
      imageUrl: widget.event.imageUrl,
      dateTime: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      ),
    )).then((_) {
      if (!mounted) return;
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }).catchError((e) {
      if (!mounted) return;
      Navigator.pop(context);
      showMessage(context, "Something went wrong", title: "Error", posText: "ok", posAction: () {  });
    });
  }
}