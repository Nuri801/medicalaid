import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalaid/components/app_constants.dart';
import 'package:medicalaid/pages/add_medicine/add_alarm_page.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key}) : super(key: key);

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _nameController = TextEditingController();
  File? _medicineImage;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: largeSpace),
                Text(
                  '어떤 약이예요?',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: largeSpace),
                Center(
                  child: MedicineImageButton(
                    changeImageFile: (File? value) {
                      _medicineImage = value;
                    },
                  ),
                ),
                const SizedBox(height: largeSpace + regularSpace),
                Text(
                  '약 이름',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextFormField(
                  controller: _nameController,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: '복용할 약 이름을 기입해주세요.',
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    contentPadding: textFieldContentPadding,
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: submitButtonPadding,
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              onPressed: _nameController.text.isEmpty ? null : _onAddAlarmPage,
              style: ElevatedButton.styleFrom(textStyle: Theme.of(context).textTheme.titleMedium),
              child: const Text('다음'),
            ),
          ),
        ),
      ),
    );
  }

  void _onAddAlarmPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAlarmPage(
          medicineImage: _medicineImage,
          medicineName: _nameController.text,
        ),
      ),
    );
  }
}


class MedicineImageButton extends StatefulWidget {
  const MedicineImageButton({
    Key? key,
    required this.changeImageFile,
  }) : super(key: key);

  final ValueChanged<File?> changeImageFile;

  @override
  State<MedicineImageButton> createState() => _MedicineImageButtonState();
}


class _MedicineImageButtonState extends State<MedicineImageButton> {

  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      child: CupertinoButton(
        padding: _pickedImage == null ? null : EdgeInsets.zero,
        onPressed: _showBottomSheet,
        child: _pickedImage == null
            ? const Icon(
                CupertinoIcons.photo_camera_solid,
                size: 30,
                color: Colors.white,
              )
            : CircleAvatar(
                foregroundImage: FileImage(_pickedImage!),
                radius: 40,
              ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return PickImageBottomSheet(
          onPressedCamera: () => _onPressed(ImageSource.camera),
          onPressedGallery: () => _onPressed(ImageSource.gallery),
        );
      },
    );
  }

  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then(
      (xFile) {
        if (xFile != null) {
          setState(() {
            _pickedImage = File(xFile.path);
            widget.changeImageFile(_pickedImage);
          });
        }
        Navigator.maybePop(context);
      },
    );
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet({Key? key, required this.onPressedCamera, required this.onPressedGallery})
      : super(key: key);

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: onPressedCamera,
              child: const Text('카메라로 활영'),
            ),
            TextButton(
              onPressed: onPressedGallery,
              child: const Text('카메라로 활영'),
            ),
          ],
        ),
      ),
    );
  }
}
