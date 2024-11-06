import 'dart:developer';
import 'dart:typed_data';

import 'package:admin/api/plant/api_plant.dart';
import 'package:admin/models/form/md_form_image.dart';
import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

import 'package:get/get.dart';

class PlantCreateScreen extends StatefulWidget with FormFuntionality {
  PlantCreateScreen({super.key});

  @override
  State<PlantCreateScreen> createState() => _PlantCreateScreenState();
}

class _PlantCreateScreenState extends State<PlantCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: 'Create Plant',
        onBackTap: () {
          widget.cancelModalWarning();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  _buildBasicInfoFormField(),
                  const Gap(20),
                  divider(),
                  const Gap(20),
                  _buildImagesFormField(),
                  const Gap(20),
                  divider(),
                  const Gap(20),
                  _buildAilmentFormField(),
                  const Gap(30),
                  _buildButtonsFormField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(
        color: Colors.grey.shade400,
      ),
    );
  }

  Widget _buildButtonsFormField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Spacer(),
          _buildCustomButton(
            Colors.red,
            title: 'Cancel',
            onTap: () {
              widget.cancelModalWarning();
            },
          ),
          const Gap(30),
          _buildCustomButton(
            const Color(0xFF007E62),
            title: 'Submit',
            onTap: () {
              widget.uploadlModalWarning();
            },
          ),
        ],
      ),
    );
  }

  void _buildModalAdd(title,
      {required Function()? onCancel, required Function()? onAdd}) {
    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(20),
      title: '$title',
      content: SizedBox(
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildTextFieldForm(
              label: 'Title',
              controller: widget.modalTitleController,
            ),
            const Gap(20),
            _buildTextFieldForm(
              label: 'Description',
              controller: widget.modalDescriptionController,
              is_Multiline: true,
            ),
            const Gap(20),
            Row(
              children: [
                const Spacer(),
                _buildCustomButton(
                  Colors.red,
                  title: 'Cancel',
                  onTap: onCancel,
                ),
                const Gap(30),
                _buildCustomButton(
                  const Color(0xFF007E62),
                  title: 'Add',
                  onTap: onAdd,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAilmentFormField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFormTitle(title: 'Ailment Associated'),
              const Spacer(),
              _buildAddButton(
                title: 'Add Ailment',
                onAdd: () {
                  _buildModalAdd(
                    'Add Ailment',
                    onCancel: () {
                      widget.modalDescriptionController.clear();
                      widget.modalTitleController.clear();
                      Get.close(1);
                    },
                    onAdd: () {
                      if (widget.modalTitleController.text.trim().isEmpty ||
                          widget.modalDescriptionController.text
                              .trim()
                              .isEmpty) {
                        return;
                      }
                      widget.ailments.add(
                        AilmentModel(
                          name: widget.modalTitleController.text,
                          description: widget.modalDescriptionController.text,
                        ),
                      );
                      setState(() {
                        widget.modalDescriptionController.clear();
                        widget.modalTitleController.clear();
                        Get.close(1);
                      });
                    },
                  );
                },
              ),
            ],
          ),
          const Gap(20),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.ailments.isEmpty ? 1 : widget.ailments.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 2,
                childAspectRatio: widget.ailments.isEmpty ? 1 / 8 : 2 / 5,
              ),
              itemBuilder: (context, index) {
                if (widget.ailments.isEmpty) {
                  return const Text(
                    'No ailments added yet.',
                    style: TextStyle(color: Colors.grey),
                  );
                }
                final ailment = widget.ailments[index];
                return InkWell(
                  onTap: () {
                    widget.modalTitleController.text = ailment.name!;
                    widget.modalDescriptionController.text =
                        ailment.description!;

                    _buildModalAdd(
                      'Edit Ailment',
                      onCancel: () {
                        widget.modalDescriptionController.clear();
                        widget.modalTitleController.clear();
                        Get.close(1);
                      },
                      onAdd: () {
                        widget.ailments[index] = AilmentModel(
                          name: widget.modalTitleController.text,
                          description: widget.modalDescriptionController.text,
                        );
                        setState(() {
                          widget.modalDescriptionController.clear();
                          widget.modalTitleController.clear();
                          Get.close(1);
                        });
                      },
                    );
                  },
                  child: Chip(
                    padding: const EdgeInsets.all(10),
                    deleteIcon: const Icon(Icons.clear),
                    deleteIconColor: Colors.red,
                    onDeleted: () {
                      setState(() {
                        widget.ailments.remove(ailment);
                      });
                    },
                    label: Text('${ailment.name}'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImagesFormField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFormTitle(title: 'Images'),
              const Spacer(),
              _buildAddButton(
                title: 'Add Image',
                onAdd: () {
                  widget.pickMultipleImages();
                },
              ),
            ],
          ),
          const Gap(20),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.otherImages.value.isEmpty
                    ? 1
                    : widget.otherImages.value.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      widget.otherImages.value.isEmpty ? 1 / 8 : 2 / 6,
                ),
                itemBuilder: (context, index) {
                  if (widget.otherImages.value.isEmpty) {
                    return const Text(
                      'No images added yet.',
                      style: TextStyle(color: Colors.grey),
                    );
                  }
                  var image = widget.otherImages.value[index];
                  return InkWell(
                    onTap: () {
                      widget.showImagePicture(image: image);
                    },
                    child: Chip(
                      padding: const EdgeInsets.all(10),
                      deleteIcon: const Icon(Icons.clear),
                      deleteIconColor: Colors.red,
                      onDeleted: () {
                        setState(() {
                          widget.otherImages.value.remove(image);
                        });
                      },
                      avatar: CircleAvatar(
                        child: Image.memory(image.bytes!),
                      ),
                      label: Text('${image.name}'),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomButton(
    Color color, {
    required String title,
    Function()? onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAddButton({required String title, Function()? onAdd}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xAEE9FCF8),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF007E62), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onAdd,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF007E62),
        ),
      ),
    );
  }

  Widget _buildBasicInfoFormField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTitle(title: 'Basic Information'),
          const Gap(20),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: _buildBasicInfoForm(),
              ),
              const Gap(40),
              Expanded(
                flex: 1,
                child: _buildCoverForm(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoForm() {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildTextFieldForm(
            label: 'Plant Name',
            controller: widget.plantNameController,
          ),
          const Gap(30),
          _buildTextFieldForm(
            label: 'Scientific Name',
            controller: widget.plantScientificNameController,
          ),
          const Gap(30),
          _buildTextFieldForm(
            label: 'Description',
            controller: widget.plantDescriptionController,
            is_Multiline: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCoverForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            if (widget.coverImage.value != null) {
              widget.showImagePicture(image: widget.coverImage.value!);
            }
          },
          child: Obx(() {
            return Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: const Color.fromARGB(255, 101, 101, 101),
                    width: 2,
                  )),
              child: widget.coverImage.value != null
                  ? Image.memory(
                      widget.coverImage.value!.bytes!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.image,
                      size: 200,
                      color: Color(0x49007E63),
                    ),
            );
          }),
        ),
        const Gap(20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xAEE9FCF8),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFF007E62), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            widget.pickCoverImage();
          },
          child: const Text(
            'Cover Image',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF007E62),
            ),
          ),
        ),
        const Gap(10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFDED4),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFF7E1D00), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            widget.coverImage.value = null;
          },
          child: const Text(
            'Clear',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF7E1D00),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormTitle({title}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        color: Color(0x27007E63),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        '$title',
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextFieldForm({label, controller, is_Multiline = false}) {
    return TextFormField(
      controller: controller,
      maxLines: is_Multiline ? 5 : 1,
      decoration: _buildFormDecoration(label: label),
    );
  }

  InputDecoration _buildFormDecoration({label}) {
    return InputDecoration(
      labelText: '$label',
      border: const OutlineInputBorder(),
    );
  }
}

mixin FormFuntionality {
  RxBool successUpload = false.obs;
  final formKey = GlobalKey<FormState>();
  final plantNameController = TextEditingController();
  final plantScientificNameController = TextEditingController();
  final plantDescriptionController = TextEditingController();
  final modalTitleController = TextEditingController();
  final modalDescriptionController = TextEditingController();

  //
  final Rx<FormImageModel?> coverImage = Rx<FormImageModel?>(null);
  final List<AilmentModel> ailments = [];
  final RxList<FormImageModel> otherImages = RxList<FormImageModel>([]);

  void pickCoverImage() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        var reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);

        await reader.onLoad.first;
        coverImage.value = FormImageModel(
          name: files[0].name,
          file: files[0],
          bytes: reader.result as Uint8List,
        );
      }
    });
  }

  void showImagePicture({required FormImageModel image}) {
    Get.defaultDialog(
      barrierDismissible: true,
      contentPadding: const EdgeInsets.all(20),
      titlePadding: const EdgeInsets.all(10),
      titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      title: '${image.name}',
      content: SizedBox(
        width: 260,
        height: 260,
        child: Image.memory(image.bytes!),
      ),
    );
  }

  void pickMultipleImages() {
    int UploadLimit = 4;
    if (otherImages.length >= UploadLimit) {
      Get.snackbar(
        margin: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 2000),
        'Limit',
        'You can only upload 4 images.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return;
    }

    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.multiple = true;

    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        int i = 0;
        for (var file in files) {
          if (i >= UploadLimit) {
            break;
          }

          var reader = html.FileReader();
          reader.readAsArrayBuffer(file);

          await reader.onLoad.first;
          var memory = reader.result as Uint8List;
          String name = file.name;
          html.File newFile = file;

          otherImages.add(
            FormImageModel(
              name: name,
              file: newFile,
              bytes: memory,
            ),
          );

          i++;
        }
      }
    });
  }

  void resetForm() {
    plantNameController.clear();
    plantScientificNameController.clear();
    plantDescriptionController.clear();
    modalTitleController.clear();
    modalDescriptionController.clear();
    coverImage.value = null;
    otherImages.clear();
    ailments.clear();
    html.window.location.reload();
  }

  void cancelModalWarning() {
    if (plantNameController.text.isEmpty &&
        plantDescriptionController.text.isEmpty &&
        plantScientificNameController.text.isEmpty &&
        coverImage.value == null &&
        otherImages.value.isEmpty &&
        ailments.isEmpty) {
      Get.offNamed(CustomRoute.path.plantsTable);
      return;
    }

    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(20),
      title: 'Cancel',
      content: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Are you sure you? \n\n',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'All unsaved changes will be lost.',
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          color: const Color(0xFF007E62),
          textColor: Colors.white,
          onPressed: () {
            Get.close(1);
          },
          child: const Text('No'),
        ),
        MaterialButton(
          color: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            Get.offNamed(CustomRoute.path.plantsTable);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }

  void uploadlModalWarning() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (coverImage.value == null) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Cover',
        'Please select an cover image.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return;
    }

    if (otherImages.isEmpty) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Images',
        'Please select at least one image.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return;
    }

    if (ailments.isEmpty) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Ailment',
        'Please add at least one ailment associated.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return;
    }

    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(20),
      title: 'Upload',
      content: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Proceed with upload? \n\n',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'You are about to upload a new plant.',
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          color: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            Get.close(1);
          },
          child: const Text('Wait'),
        ),
        MaterialButton(
          color: const Color(0xFF007E62),
          textColor: Colors.white,
          onPressed: () {
            Get.close(1);
            submitForm();
          },
          child: const Text('Proceed'),
        ),
      ],
    );
  }

  void loadingModal({title, subtitle}) {
    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(20),
      title: '$title',
      content: SizedBox(
        width: 230,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$subtitle'),
            const Gap(15),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  void failedModal({title, subtitle}) {
    Get.defaultDialog(
        barrierDismissible: false,
        titlePadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(20),
        title: '$title',
        content: Text('$subtitle'),
        actions: [
          MaterialButton(
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () {
              Get.close(1);
            },
            child: const Text('Ok'),
          ),
        ]);
  }

  void successModal({title, subtitle}) {
    Get.defaultDialog(
        barrierDismissible: false,
        titlePadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(20),
        title: '$title',
        content: Text('$subtitle'),
        actions: [
          MaterialButton(
            color: const Color(0xFF007E62),
            textColor: Colors.white,
            onPressed: () {
              Get.close(1);
              resetForm();
            },
            child: const Text('Ok'),
          ),
        ]);
  }

  void submitForm() async {
    bool isSuccess = false;

    var user = await SessionAccess.instance.getSessionData();
    var plant = PlantModel(
      name: plantNameController.text,
      description: plantDescriptionController.text,
      scientific: plantScientificNameController.text,
      user_create_by: user,
    );

    loadingModal(title: 'Uploading plant...', subtitle: 'Please wait...');
    var plantUploaded =
        await ApiPlant.uploadPlant(plant: plant, cover: coverImage.value!);

    if (plantUploaded == null) {
      Get.close(1);
      failedModal(title: 'Failed', subtitle: 'Failed to upload plant');
      print('fail');
      return;
    }
    //
    print(plantUploaded.id);
    for (var ailment in ailments) {
      //
      var configAilment = AilmentModel(
        name: ailment.name,
        description: ailment.description,
        plant_id: plantUploaded.id!,
      );
      var uploadedAilment = await ApiPlant.uploadPlantAilment(configAilment);
      print(uploadedAilment?.id ?? 'fail');
      if (uploadedAilment == null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'Failed to upload ailments');
        return;
      }
    }

    for (var image in otherImages) {
      var uploadedImage = await ApiPlant.uploadPlantImage(plantUploaded, image);

      print(uploadedImage?.id ?? 'fail');
      if (uploadedImage == null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'Failed to upload images');
        return;
      }
    }
    Get.close(1);

    successModal(title: 'Success', subtitle: 'Plant uploaded successfully');
  }
}
