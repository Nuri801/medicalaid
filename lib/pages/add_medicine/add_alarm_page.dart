import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalaid/components/app_constants.dart';
import 'package:medicalaid/pages/components/add_page_body.dart';

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
              ],
            ),
          ),
          // medicineImage == null ? Container() : Image.file(medicineImage!),
          // Text(medicineName),
        ],
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
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.minus_circle)),
        Expanded(child: TextButton(onPressed: () {}, child: Text('18:00'))),
      ],
    );
  }
}
