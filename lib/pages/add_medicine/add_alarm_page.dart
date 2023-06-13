import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicalaid/components/app_constants.dart';
import 'package:medicalaid/components/app_widgets.dart';
import 'package:medicalaid/pages/components/add_page_widgets.dart';

import '../../components/app_colors.dart';

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({
    Key? key,
    required this.medicineImage,
    required this.medicineName,
  }) : super(key: key);

  final File? medicineImage;
  final String medicineName;

  @override
  State<AddAlarmPage> createState() => _AddAlarmPageState();
}

class _AddAlarmPageState extends State<AddAlarmPage> {
  final _alarms = <String>{'08:00', '13:00', '19:00'};

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
            child: ListView(
              children: alarmWidgets,
            ),
          ),
          // medicineImage == null ? Container() : Image.file(medicineImage!),
          // Text(medicineName),
        ],
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: () {},
        text: '완료',
      ),
    );
  }

  List<Widget> get alarmWidgets {
    final children = <Widget>[];
    children.addAll(
      _alarms.map(
        (alarmTime) => AlarmBox(
          time: alarmTime,
          onPressedMinus: () {
            setState(() {
              _alarms.remove(alarmTime);
            });
          },
        ),
      ),
    );
    children.add(
      AddAlarmButton(
        onPressed: () {
          final now = DateTime.now();
          final nowTime = DateFormat('HH:mm').format(now);
          setState(() {
            _alarms.add(nowTime);
          });
        },
      ),
    );
    return children;
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({
    super.key,
    required this.time,
    required this.onPressedMinus,
  });

  final String time;
  final VoidCallback onPressedMinus;

  @override
  Widget build(BuildContext context) {
    final initTime = DateFormat('HH:mm').parse(time);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: onPressedMinus,
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
                    initialDateTime: initTime,
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

class TimiPickerBottomSheet extends StatelessWidget {
  const TimiPickerBottomSheet({
    super.key,
    required this.initialDateTime,
  });

  final DateTime initialDateTime;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            onDateTimeChanged: (dateTime) {},
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
                  onPressed: () {},
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                  ),
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
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
      onPressed: onPressed,
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
