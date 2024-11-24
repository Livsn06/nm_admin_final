import 'dart:developer';
import 'dart:typed_data';

import 'package:admin/api/image/api_image.dart';
import 'package:admin/api/plant/api_plant.dart';
import 'package:admin/models/form/md_form_image.dart';
import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/models/plant/md_plant_local_name.dart';
import 'package:admin/models/plant/md_plant_treatment.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:admin/sessions/sn_plant.dart';
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
  void initState() {
    super.initState();
    widget.checkEditMode(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: widget.isEditMode.value ? 'Edit Plant' : 'Create Plant',
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
                  _buildLocalNameFormField(),
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
              if (widget.isEditMode.value) {
                widget.updateModalWarning();
              } else {
                widget.uploadModalWarning();
              }
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

  void _buildModalLocalNameAdd(title,
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
              label: 'Name',
              controller: widget.modalLocalNameController,
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
                        PlantTreatmentModel(
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
                        widget.ailments[index] = PlantTreatmentModel(
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

  Widget _buildLocalNameFormField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFormTitle(title: 'Local Name'),
              const Spacer(),
              _buildAddButton(
                title: 'Add Local Name',
                onAdd: () {
                  _buildModalLocalNameAdd('Add Local Name', onCancel: () {
                    widget.modalLocalNameController.clear();
                    Get.close(1);
                  }, onAdd: () {
                    widget.localNames.add(widget.modalLocalNameController.text);
                    setState(() {
                      widget.modalLocalNameController.clear();
                      Get.close(1);
                    });
                  });
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
              itemCount:
                  widget.localNames.isEmpty ? 1 : widget.localNames.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: widget.localNames.isEmpty ? 1 / 8 : 2 / 6,
              ),
              itemBuilder: (context, index) {
                if (widget.localNames.isEmpty) {
                  return const Text(
                    'No local name added yet.',
                    style: TextStyle(color: Colors.grey),
                  );
                }
                var name = widget.localNames[index];
                return InkWell(
                  onTap: () {
                    widget.modalLocalNameController.text = name;
                    _buildModalLocalNameAdd(
                      'Edit Local Name',
                      onCancel: () {
                        widget.modalLocalNameController.clear();
                        Get.close(1);
                      },
                      onAdd: () {
                        widget.localNames[index] =
                            widget.modalLocalNameController.text;
                        setState(() {
                          widget.modalLocalNameController.clear();
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
                        widget.localNames.remove(name);
                      });
                    },
                    label: Text(name),
                  ),
                );
              },
            ),
          ),
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
            isReadOnly: widget.isEditMode.value,
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

  Widget _buildTextFieldForm({
    label,
    controller,
    is_Multiline = false,
    isReadOnly = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: is_Multiline ? 5 : 1,
      readOnly: isReadOnly,
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
  final modalLocalNameController = TextEditingController();

  //
  final Rx<FormImageModel?> coverImage = Rx<FormImageModel?>(null);
  final List<String> localNames = [];
  final List<PlantTreatmentModel> ailments = [];
  final RxList<FormImageModel> otherImages = RxList<FormImageModel>([]);
  final RxString progressMessage = ''.obs;
  final RxBool isEditMode = false.obs;

  void pickCoverImage() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/jpeg,image/png,image/jpg';
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
    //only jpeg, png and jpg
    uploadInput.accept = 'image/jpeg,image/png,image/jpg';
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
            exitEditMode();
            Get.offNamed(CustomRoute.path.plantsTable);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }

  void uploadModalWarning() {
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

  //

  void updateModalWarning() {
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
      title: 'Update',
      content: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Proceed with update? \n\n',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: 'You are about to update this plant.',
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
            updateForm();
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
        height: 90,
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(progressMessage.value),
              const Gap(15),
              const CircularProgressIndicator(),
            ],
          );
        }),
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

  void checkEditMode(void Function() setState) async {
    try {
      var plant = await SessionPlant.getEditPlant();
      if (plant != null) {
        isEditMode.value = true;
        plantNameController.text = plant.name!;
        plantDescriptionController.text = plant.description!;
        plantScientificNameController.text = plant.scientific_name!;

        //
        var value = await ApiImage.getImage(plant.cover!);
        if (value != null) {
          coverImage.value = FormImageModel(
            name: value.file_name,
            bytes: value.image_data,
          );
        } else {
          coverImage.value = null;
        }

        //
        if (plant.images != null) {
          for (var i = 0; i < plant.images!.length; i++) {
            print(plant.images![i].path);
            var value = await ApiImage.getImage(plant.images![i].path!);
            if (value != null) {
              otherImages.add(
                FormImageModel(
                  id: plant.images![i].id,
                  name: value.file_name,
                  bytes: value.image_data,
                ),
              );
            }
          }
        }

        //

        if (plant.ailments != null) {
          for (var ailment in plant.ailments!) {
            print(ailment.name);
            ailments.add(ailment);
          }
        }

        //
        if (plant.local_name != null) {
          for (var i = 0; i < plant.local_name!.length; i++) {
            localNames.add(plant.local_name![i].name!);
          }
        }
      }

      //
    } catch (e) {
      printError(info: e.toString());
    }

    setState();
  }

  void exitEditMode() {
    isEditMode.value = false;
    SessionPlant.removeEditPlant();
  }

  void submitForm() async {
    bool isSuccess = false;

    var user = await SessionAccess.instance.getSessionData();

    // -----------------------------------------------
    var plant = PlantModel(
      name: plantNameController.text,
      description: plantDescriptionController.text,
      scientific_name: plantScientificNameController.text,
      create_by: user,
    );

    progressMessage.value = 'Uploading your plant...';
    loadingModal(title: 'Creating Plant');
    var response = await ApiPlant.uploadPlant(plant: plant);

    if (response.success == false || response.errors != null) {
      Get.close(1);
      failedModal(title: 'Failed', subtitle: 'Failed to create plant');
      return;
    }

    if (response.clientError ?? false) {
      Get.close(1);
      failedModal(title: 'Failed', subtitle: response.message!);
      return;
    }
    //
    var plantUploaded = PlantModel.fromJson(response.data!);
    if (plantUploaded.id == null) {
      Get.close(1);
      failedModal(
        title: 'Program Failed',
        subtitle: 'Could not fetch the plant id.',
      );
      return;
    }

    print('Plant ID: ${plantUploaded.id}');
    //--------------------------------------------------------------
    progressMessage.value = 'Uploading treatments...';
    for (var ailment in ailments) {
      //
      var configAilment = PlantTreatmentModel(
        name: ailment.name,
        description: ailment.description,
        plant_id: plantUploaded.id,
      );
      var response = await ApiPlant.uploadTeatment(configAilment);

      if (response.success == false || response.errors != null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'Failed to create ailment');
        return;
      }

      if (response.clientError ?? false) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: response.message!);
        return;
      }
    }

    //--------------------------------------------------------------
    progressMessage.value = 'Uploading local names...';
    for (var lcName in localNames) {
      //
      var configLCN = PlantLocalNameModel(
        name: lcName,
        plant_id: plantUploaded.id,
      );
      var response = await ApiPlant.uploadLocalName(configLCN);

      if (response.success == false || response.errors != null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'Failed to create local names');
        return;
      }

      if (response.clientError ?? false) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: response.message!);
        return;
      }
    }

    //--------------------------------------------------------------
    progressMessage.value = 'Uploading images...';
    response = await ApiPlant.uploadCover(plantUploaded, coverImage.value!);

    if (response.success == false || response.errors != null) {
      Get.close(1);
      failedModal(title: 'Failed', subtitle: 'Failed to upload cover image');
      return;
    }

    if (response.clientError ?? false) {
      Get.close(1);
      failedModal(title: 'Failed', subtitle: response.message!);
      return;
    }

    //--------------------------------------------------------------

    for (var image in otherImages) {
      response = await ApiPlant.uploadImage(plantUploaded, image);

      if (response.success == false || response.errors != null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'Failed to upload image');
        return;
      }

      if (response.clientError ?? false) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: response.message!);
        return;
      }
    }

    Get.close(1);
    successModal(title: 'Success', subtitle: 'Plant uploaded successfully');
  }

  ///

  void updateForm() async {
    try {
      bool isSuccess = false;

      var user = await SessionAccess.instance.getSessionData();
      var oldPlant = await SessionPlant.getEditPlant();

      // -----------------------------------------------
      if (oldPlant == null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'Plant not found');
        return;
      }

      //
      if (user.id == null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'User not found');
        return;
      }

      var plant = PlantModel(
        id: oldPlant.id,
        name: plantNameController.text,
        description: plantDescriptionController.text,
        scientific_name: plantScientificNameController.text,
        update_by: user,
        create_by: user,
      );

      progressMessage.value = 'Updating your plant...';
      loadingModal(title: 'Updating Plant');

      var response = await ApiPlant.updatePlant(plant: plant);

      if (response.success == false || response.errors != null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'Failed to update plant');
        return;
      }

      if (response.clientError ?? false) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: response.message!);
        return;
      }

      //--------------------------------------------------------------
      progressMessage.value = 'Updating treatments...';

      if (ailments.isNotEmpty) {
        //

        await ApiPlant.clearTreatments(oldPlant.id!);

        for (var ailment in ailments) {
          //
          var configAilment = PlantTreatmentModel(
            name: ailment.name,
            description: ailment.description,
            plant_id: oldPlant.id,
          );

          response = await ApiPlant.uploadTeatment(configAilment);

          if (response.success == false || response.errors != null) {
            Get.close(1);
            failedModal(title: 'Failed', subtitle: 'Failed to update ailment');
            return;
          }

          if (response.clientError ?? false) {
            Get.close(1);
            failedModal(title: 'Failed', subtitle: response.message!);
            return;
          }
        }
      }

      //--------------------------------------------------------------
      progressMessage.value = 'Updating local names...';
      if (localNames.isNotEmpty) {
        await ApiPlant.clearLocalNames(oldPlant);
      }
      for (var lcName in localNames) {
        //
        var configLCN = PlantLocalNameModel(
          name: lcName,
          plant_id: oldPlant.id,
        );
        var response = await ApiPlant.uploadLocalName(configLCN);

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
              title: 'Failed', subtitle: 'Failed to update local names');
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(title: 'Failed', subtitle: response.message!);
          return;
        }
      }

      //--------------------------------------------------------------
      progressMessage.value = 'Updating images...';

      if (otherImages.value.isNotEmpty) {
        await ApiPlant.clearImages(oldPlant);
      }

      response = await ApiPlant.uploadCover(oldPlant, coverImage.value!);

      if (response.success == false || response.errors != null) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: 'Failed to update cover image');
        return;
      }

      if (response.clientError ?? false) {
        Get.close(1);
        failedModal(title: 'Failed', subtitle: response.message!);
        return;
      }

      //--------------------------------------------------------------

      for (var image in otherImages) {
        response = await ApiPlant.uploadImage(oldPlant, image);

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(title: 'Failed', subtitle: 'Failed to update image');
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(title: 'Failed', subtitle: response.message!);
          return;
        }
      }

      Get.close(1);
      successModal(title: 'Success', subtitle: 'Plant updated successfully');
    } catch (e) {
      Get.close(1);
      failedModal(title: 'Failed', subtitle: 'Failed to update plant');
      printError(info: e.toString());
    }
  }
}
