import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalaid/components/app_constants.dart';
import 'package:medicalaid/pages/components/add_page_widgets.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage({
    Key? key,
    required this.medicineImage,
    required this.medicineName,
  }) : super(key: key);

  final File? medicineImage;
  final String medicineName;

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
              children: [
                AlarmBox(),
                AlarmBox(),
                AlarmBox(),
                AlarmBox(),
                AlarmBox(),
                AddAlarmBox(),
              ],
            ),
          ),
          // medicineImage == null ? Container() : Image.file(medicineImage!),
          // Text(medicineName),
        ],
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) {
            return Column();
          });
        },
        text: '완료',
      ),
    );
  }
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.minus_circle,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            onPressed: () {},
            child: Text(
              '18:00',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ],
    );
  }
}

class AddAlarmBox extends StatelessWidget {
  const AddAlarmBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        textStyle: Theme.of(context).textTheme.titleMedium,
      ),
      onPressed: () {},
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
