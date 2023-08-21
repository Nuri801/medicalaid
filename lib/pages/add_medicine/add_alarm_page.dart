import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicalaid/components/app_constants.dart';
import 'package:medicalaid/components/app_widgets.dart';
import 'package:medicalaid/pages/components/add_page_widgets.dart';
import 'package:medicalaid/services/add_medicine_service.dart';
import '../../components/app_colors.dart';

class AddAlarmPage extends StatelessWidget {
  AddAlarmPage({
    Key? key,
    required this.medicineImage,
    required this.medicineName,
  }) : super(key: key);
  final File? medicineImage;
  final String medicineName;
  final service = AddMedicineService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddPageBody(
        children: [
          Text(
            '매일 복약 잊지말아요!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: largeSpace,
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: service,
              builder: (context, _) {
                return ListView(
                  children: alarmWidgets,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: () {
          // 1. add alarm
          // 2. save image (local dir)
          // 3. add medicine model (local DB, hive)
        },
        text: '완료',
      ),
    );
  }


  List<Widget> get alarmWidgets {
    final children = <Widget>[];
    children.addAll(
      service.alarms.map(
        (alarmTime) => AlarmBox(
          time: alarmTime,
          service: service,
        ),
      ),
    );
    children.add(
      AddAlarmButton(
        service: service,
      ),
    );
    return children;
  }
}

// I think the following structure of having separate classes for widgets
// is not necessary as we have to pass down the State controller object to each class.
// But that is what the instructor did.
// A better way would be to create methods with a return type of Widget inside one class,
// thus being able to access the manager object from anywhere without having to pass down.
class AlarmBox extends StatelessWidget {
  const AlarmBox({
    super.key,
    required this.time,
    required this.service,
  });
  final String time;
  final AddMedicineService service;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {
              service.removeAlarm(time);
            },
            icon: const Icon(
              CupertinoIcons.minus_circle,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return TimiPickerBottomSheet(
                    initialTime: time,
                    service: service,
                  );
                },
              );
            },
            child: Text(
              time,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}


// ignore: must_be_immutable
class TimiPickerBottomSheet extends StatelessWidget {
  TimiPickerBottomSheet({
    super.key,
    required this.initialTime,
    required this.service,
  });

  final String initialTime;
  final AddMedicineService service;
  DateTime? _setDateTime;

  @override
  Widget build(BuildContext context) {
    final initialDateTime = DateFormat('HH:mm').parse(initialTime);
    return BottomSheetBody(
      children: [
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {
              _setDateTime = dateTime;
            },
            mode: CupertinoDatePickerMode.time,
            initialDateTime: initialDateTime,
          ),
        ),
        const SizedBox(
          height: regularSpace,
        ),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('취소'),
                ),
              ),
            ),
            const SizedBox(
              width: smallSpace,
            ),
            Expanded(
              child: SizedBox(
                height: submitButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  onPressed: () {
                    service.setAlarm(
                      prevTime: initialTime,
                      setTime: _setDateTime ?? initialDateTime,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('선택'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AddAlarmButton extends StatelessWidget {

  const AddAlarmButton({
    super.key,
    required this.service,
  });
  final AddMedicineService service;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
      onPressed: service.addNowAlarm,
      child: const Row(
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              CupertinoIcons.plus_circle_fill,
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                '복용시간 추가',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
