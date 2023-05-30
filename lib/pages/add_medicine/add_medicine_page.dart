import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalaid/components/app_constants.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({Key? key}) : super(key: key);

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _nameController = TextEditingController();

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
                const Center(
                  child: MedicineImageButton(),
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
              onPressed: () {
                // do something here:
              },
              style: ElevatedButton.styleFrom(textStyle: Theme.of(context).textTheme.titleMedium),
              child: const Text('다음'),
            ),
          ),
        ),
      ),
    );
  }
}

class MedicineImageButton extends StatefulWidget {
  const MedicineImageButton({Key? key}) : super(key: key);

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
          return SafeArea(
            child: Padding(
              padding: pagePadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      ImagePicker().pickImage(source: ImageSource.camera).then((xFile) {
                        if (xFile != null) {
                          setState(() {
                            _pickedImage = File(xFile.path);
                          });
                        }
                        Navigator.maybePop(context);
                      });
                    },
                    child: const Text('카메라로 활영'),
                  ),
                  TextButton(
                    onPressed: () {
                      ImagePicker().pickImage(source: ImageSource.gallery).then((xFile) {
                        if (xFile != null) {
                          setState(() {
                            _pickedImage = File(xFile.path);
                          });
                        }
                        Navigator.maybePop(context);
                      });
                    },
                    child: const Text('카메라로 활영'),
                  ),
                ],
              ),
            ),
          );
        });
  }

}

