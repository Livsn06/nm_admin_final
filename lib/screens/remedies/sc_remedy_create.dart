import 'dart:typed_data';

import 'package:admin/api/remedy/api_remedy.dart';
import 'package:admin/controllers/ct_plant.dart';
import 'package:admin/models/form/md_form_image.dart';
import 'package:admin/models/plant/md_plant.dart';
import 'package:admin/models/remedies/md_ailment.dart';
import 'package:admin/models/remedies/md_ingredient.dart';
import 'package:admin/models/remedies/md_remedy.dart';
import 'package:admin/models/remedies/md_step.dart';
import 'package:admin/models/remedies/md_usage.dart';
import 'package:admin/models/response/md_response.dart';
import 'package:admin/models/user/md_user.dart';
import 'package:admin/routes/rt_routers.dart';
import 'package:admin/sessions/sn_access.dart';
import 'package:admin/sessions/sn_remedy.dart';
import 'package:admin/widgets/wg_appbar.dart';
import 'package:admin/widgets/wg_dropdown.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:html' as html;

import 'package:get/get.dart';

import '../../api/image/api_image.dart';

class RemedyCreateScreen extends StatefulWidget with FormFunctionality {
  RemedyCreateScreen({super.key});

  @override
  State<RemedyCreateScreen> createState() => _RemedyCreateScreenState();
}

class _RemedyCreateScreenState extends State<RemedyCreateScreen> {
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
        title: widget.isEditMode.value ? 'Edit Remedy' : 'Create Remedy',
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
                  _buildAddPlantForm(),
                  const Gap(30),
                  divider(),
                  const Gap(20),
                  _buildBasicInfoFormField(),
                  const Gap(20),
                  divider(),
                  const Gap(20),
                  _buildImagesFormField(),
                  const Gap(20),
                  divider(),
                  const Gap(20),
                  _buildAilmentFormField(),
                  const Gap(20),
                  divider(),
                  const Gap(20),
                  _buildStepsFormField(),
                  const Gap(20),
                  divider(),
                  const Gap(20),
                  _buildUsageFormField(),
                  const Gap(20),
                  divider(),
                  const Gap(20),
                  _buildIngredientsFormField(),
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

  Widget _buildIngredientsFormField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFormTitle(title: 'Ingredients'),
              const Spacer(),
              _buildAddButton(
                title: 'Add Ingredient',
                onAdd:
                    widget.plantDropdownController.value.dropDownValue != null
                        ? () {
                            _buildModalAdd(
                              'Add Ingredient',
                              onCancel: () {
                                Get.close(1);
                              },
                              onAdd: () {
                                widget.ingredients.add(
                                  IngredientModel(
                                    name: widget.modalTitleController.text,
                                    description:
                                        widget.modalDescriptionController.text,
                                  ),
                                );

                                setState(() {
                                  widget.modalDescriptionController.clear();
                                  widget.modalTitleController.clear();
                                  Get.close(1);
                                });
                              },
                            );
                          }
                        : null,
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
                  widget.ingredients.isEmpty ? 1 : widget.ingredients.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 1,
                childAspectRatio: widget.ingredients.isEmpty ? 1 / 8 : 2 / 5,
              ),
              itemBuilder: (context, index) {
                if (widget.ingredients.isEmpty) {
                  return const Text(
                    'No ingredients added yet',
                    style: TextStyle(color: Colors.grey),
                  );
                }

                final ingredient = widget.ingredients[index];

                return InkWell(
                  onTap: () {
                    widget.modalTitleController.text = ingredient.name!;
                    widget.modalDescriptionController.text =
                        ingredient.description!;
                    _buildModalAdd(
                      'Edit Usage',
                      onCancel: () {
                        Get.close(1);
                        widget.modalDescriptionController.clear();
                        widget.modalTitleController.clear();
                      },
                      onAdd: () {
                        widget.ingredients[index] = IngredientModel(
                          name: widget.modalTitleController.text,
                          description: widget.modalDescriptionController.text,
                        );
                        setState(() {
                          Get.close(1);
                          widget.modalDescriptionController.clear();
                          widget.modalTitleController.clear();
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
                        widget.ingredients.remove(ingredient);
                      });
                    },
                    label: Text('${ingredient.name}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsageFormField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFormTitle(title: 'Usages'),
              const Spacer(),
              _buildAddButton(
                title: 'Add Usage',
                onAdd:
                    widget.plantDropdownController.value.dropDownValue != null
                        ? () {
                            _buildModalAdd(
                              'Add Usage',
                              onCancel: () {
                                Get.close(1);
                              },
                              onAdd: () {
                                widget.usages.add(
                                  UsageModel(
                                    name: widget.modalTitleController.text,
                                    description:
                                        widget.modalDescriptionController.text,
                                  ),
                                );

                                setState(() {
                                  widget.modalDescriptionController.clear();
                                  widget.modalTitleController.clear();
                                  Get.close(1);
                                });
                              },
                            );
                          }
                        : null,
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
              itemCount: widget.usages.isEmpty ? 1 : widget.usages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
                childAspectRatio: widget.usages.isEmpty ? 1 / 8 : 2 / 5,
              ),
              itemBuilder: (context, index) {
                if (widget.usages.isEmpty) {
                  return const Text(
                    'No usages added yet',
                    style: TextStyle(color: Colors.grey),
                  );
                }

                //
                final usage = widget.usages[index];
                return InkWell(
                  onTap: () {
                    widget.modalTitleController.text = usage.name!;
                    widget.modalDescriptionController.text = usage.description!;
                    _buildModalAdd(
                      'Edit Usage',
                      onCancel: () {
                        Get.close(1);
                        widget.modalDescriptionController.clear();
                        widget.modalTitleController.clear();
                      },
                      onAdd: () {
                        widget.usages[index] = UsageModel(
                          name: widget.modalTitleController.text,
                          description: widget.modalDescriptionController.text,
                        );
                        setState(() {
                          Get.close(1);
                          widget.modalDescriptionController.clear();
                          widget.modalTitleController.clear();
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
                        widget.usages.remove(usage);
                      });
                    },
                    label: Text('${usage.name}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsFormField() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFormTitle(title: 'Steps'),
              const Spacer(),
              _buildAddButton(
                title: 'Add Step',
                onAdd:
                    widget.plantDropdownController.value.dropDownValue != null
                        ? () {
                            _buildModalAdd(
                              'Add Step',
                              onCancel: () {
                                Get.close(1);
                              },
                              onAdd: () {
                                widget.steps.add(
                                  StepModel(
                                    name: widget.modalTitleController.text,
                                    description:
                                        widget.modalDescriptionController.text,
                                  ),
                                );

                                setState(() {
                                  widget.modalDescriptionController.clear();
                                  widget.modalTitleController.clear();
                                  Get.close(1);
                                });
                              },
                            );
                          }
                        : null,
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
              itemCount: widget.steps.isEmpty ? 1 : widget.steps.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 5,
                mainAxisSpacing: 2,
                childAspectRatio: widget.steps.isEmpty ? 1 / 8 : 2 / 5,
              ),
              itemBuilder: (context, index) {
                if (widget.steps.isEmpty) {
                  return const Text(
                    'No steps added yet',
                    style: TextStyle(color: Colors.grey),
                  );
                }

                final step = widget.steps[index];
                return InkWell(
                  onTap: () {
                    widget.modalTitleController.text = step.name!;
                    widget.modalDescriptionController.text = step.description!;
                    _buildModalAdd(
                      'Edit Step',
                      onCancel: () {
                        Get.close(1);
                        widget.modalDescriptionController.clear();
                        widget.modalTitleController.clear();
                      },
                      onAdd: () {
                        widget.steps[index] = StepModel(
                          name: widget.modalTitleController.text,
                          description: widget.modalDescriptionController.text,
                        );
                        setState(() {
                          Get.close(1);
                          widget.modalDescriptionController.clear();
                          widget.modalTitleController.clear();
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
                        widget.steps.remove(step);
                      });
                    },
                    label: Text('${step.name}'),
                  ),
                );
              },
            ),
          ),
        ],
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
                onAdd:
                    widget.plantDropdownController.value.dropDownValue != null
                        ? () {
                            _buildModalAdd(
                              'Add Ailment',
                              onCancel: () {
                                Get.close(1);
                              },
                              onAdd: () {
                                widget.ailments.add(
                                  RemedyTreatmentModel(
                                    name: widget.modalTitleController.text,
                                    description:
                                        widget.modalDescriptionController.text,
                                  ),
                                );

                                setState(() {
                                  widget.modalDescriptionController.clear();
                                  widget.modalTitleController.clear();
                                  Get.close(1);
                                });
                              },
                            );
                          }
                        : null,
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
                mainAxisSpacing: 10,
                childAspectRatio: widget.ailments.isEmpty ? 1 / 8 : 2 / 5,
              ),
              itemBuilder: (context, index) {
                if (widget.ailments.isEmpty) {
                  return const Text(
                    'No ailments added yet',
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
                        Get.close(1);
                        widget.modalDescriptionController.clear();
                        widget.modalTitleController.clear();
                      },
                      onAdd: () {
                        widget.ailments[index] = RemedyTreatmentModel(
                          name: widget.modalTitleController.text,
                          description: widget.modalDescriptionController.text,
                        );
                        setState(() {
                          Get.close(1);
                          widget.modalDescriptionController.clear();
                          widget.modalTitleController.clear();
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
                onAdd:
                    widget.plantDropdownController.value.dropDownValue != null
                        ? () {
                            widget.pickMultipleImages();
                          }
                        : null,
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
                          widget.otherImages.value.removeAt(index);
                        });
                      },
                      avatar: CircleAvatar(
                        child: Image.memory(image.bytes!),
                      ),
                      label: Text(image.name!),
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
          _buildFormTitle(title: 'Remedy Information'),
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

  Widget _buildAddPlantForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFormTitle(title: 'Plant Information'),
              const Spacer(),
              _buildAddButton(
                title: 'Select Plant',
                onAdd: () {
                  _buildModalAddPlant('Select Plant');
                },
              ),
            ],
          ),
          const Gap(20),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(40),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Obx(() {
                        return Column(
                          children: [
                            _buildTextFieldForm(
                              label: 'Plant Name',
                              isReadOnly: true,
                              controller: TextEditingController(
                                text: widget.plantDropdownController.value
                                        .dropDownValue?.value.name ??
                                    '',
                              ),
                            ),
                            const Gap(20),
                            _buildTextFieldForm(
                              label: 'Scientific Name',
                              isReadOnly: true,
                              controller: TextEditingController(
                                  text: widget
                                          .plantDropdownController
                                          .value
                                          .dropDownValue
                                          ?.value
                                          .scientific_name ??
                                      ''),
                            ),
                          ],
                        );
                      }),
                    ),
                    const Gap(40),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (widget.plantDropdownController.value
                                      .dropDownValue!.value.cover !=
                                  null) {
                                widget.showImagePicture(
                                    image: widget.plantDropdownController.value
                                        .dropDownValue!.value.cover);
                              }
                            },
                            child: Obx(() {
                              return Container(
                                width: 150,
                                height: 150,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 101, 101, 101),
                                      width: 2,
                                    )),
                                child: widget.plantDropdownController.value
                                            .dropDownValue !=
                                        null
                                    ? _loadingImage(widget
                                        .plantDropdownController
                                        .value
                                        .dropDownValue!
                                        .value
                                        .cover)
                                    : const Icon(
                                        Icons.image,
                                        size: 120,
                                        color: Color(0x49007E63),
                                      ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingImage(path) {
    if (path == null) {
      return Image.asset('assets/placeholder/plant_image1.jpg');
    }

    return FutureBuilder(
      future: ApiImage.getImage(path),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return Image.asset('assets/placeholder/plant_image1.jpg');
        }
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Image.memory(
            data!.image_data!,
            fit: BoxFit.cover,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildBasicInfoForm() {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildTextFieldForm(
            label: 'Remedy Name',
            controller: widget.nameController,
          ),
          const Gap(30),
          _buildTextFieldForm(
            label: 'Remedy Type',
            controller: widget.typeController,
          ),
          const Gap(30),
          _buildTextFieldForm(
            label: 'Description',
            controller: widget.descriptionController,
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
          onPressed: widget.plantDropdownController.value.dropDownValue != null
              ? () {
                  widget.pickCoverImage();
                }
              : null,
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

  Widget _buildTextFieldForm(
      {label, controller, is_Multiline = false, isReadOnly = false}) {
    return TextFormField(
      controller: controller,
      maxLines: is_Multiline ? 5 : 1,
      readOnly: isReadOnly ||
          widget.plantDropdownController.value.dropDownValue == null,
      decoration: _buildFormDecoration(label: label),
      validator: (value) {
        if (GetUtils.isNull(value) ||
            GetUtils.removeAllWhitespace(value!).isEmpty) {
          return 'Required. please fill this form.';
        }
        return null;
      },
    );
  }

  InputDecoration _buildFormDecoration({label}) {
    return InputDecoration(
      labelText: '$label',
      border: const OutlineInputBorder(),
    );
  }

  void _buildModalAdd(title, {Function()? onAdd, Function()? onCancel}) {
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

  void _buildModalAddPlant(title) {
    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(20),
      title: '$title',
      content: Form(
        key: widget.modalFormKey,
        child: SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              customDropDown(
                hintText: 'Select Plant',
                validator: (value) {
                  if (value == null) {
                    return 'Required. please select a plant.';
                  }
                  return null;
                },
                controller: widget.plantDropdownController.value,
                dataValue: widget.plantController.plantData,
                onChange: (value) {},
              ),
              const Gap(20),
              Row(
                children: [
                  const Spacer(),
                  _buildCustomButton(
                    Colors.red,
                    title: 'Cancel',
                    onTap: () {
                      Get.close(1);
                    },
                  ),
                  const Gap(30),
                  _buildCustomButton(
                    const Color(0xFF007E62),
                    title: 'Select',
                    onTap: () {
                      setState(() {
                        widget.selectedPlant();
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

mixin FormFunctionality {
  final plantController = Get.put(PlantController());
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final descriptionController = TextEditingController();

  final Rx<SingleValueDropDownController> plantDropdownController =
      Rx(SingleValueDropDownController());
  //
  final modalFormKey = GlobalKey<FormState>();
  final modalTitleController = TextEditingController();
  final modalDescriptionController = TextEditingController();

  //
  Rx<FormImageModel?> coverImage = Rx<FormImageModel?>(null);
  final RxList<FormImageModel> otherImages = <FormImageModel>[].obs;

  //
  final List<String> symptoms = [];
  final List<IngredientModel> ingredients = [];
  final List<UsageModel> usages = [];
  final List<RemedyTreatmentModel> ailments = [];
  final List<StepModel> steps = [];
  RxString progressMessage = ''.obs;
  RxBool isEditMode = false.obs;

  void selectedPlant() {
    if (plantDropdownController.value.dropDownValue == null) {
      Get.snackbar(
        margin: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 2000),
        'Empty',
        'No selected plant.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
    }

    Get.close(1);
  }

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

  bool isValidPlant() {
    if (plantDropdownController.value.dropDownValue == null) {
      Get.snackbar(
        margin: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 2000),
        'Error',
        'Please select plant',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return false;
    }
    return true;
  }

  bool isValidRemedyForm() {
    if (coverImage.value == null) {
      Get.snackbar(
        margin: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 2000),
        'Error',
        'Please add remedy a cover.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return false;
    }

    if (nameController.text.trim() == '' &&
        typeController.text == '' &&
        descriptionController.text == '') {
      //
      Get.snackbar(
        margin: const EdgeInsets.all(10),
        duration: const Duration(milliseconds: 2000),
        'Error',
        'Please fill all required form.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return false;
    }
    return true;
  }

  void resetForm() {
    nameController.clear();
    typeController.clear();
    descriptionController.clear();
    otherImages.clear();
    steps.clear();
    ingredients.clear();
    ailments.clear();
    usages.clear();

    modalTitleController.clear();
    modalDescriptionController.clear();
    coverImage.value = null;
    otherImages.clear();
    ailments.clear();
    html.window.location.reload();
  }

  void checkEditMode(void Function() setState) async {
    // try {
    //   var remedy = await SessionRemedy.getEditRemedy();
    //   if (remedy != null) {
    //     isEditMode.value = true;
    //     plantDropdownController.value.dropDownValue = DropDownValueModel(
    //       name: remedy.plant!.name!,
    //       value: remedy.plant,
    //     );

    //     nameController.text = remedy.name!;
    //     typeController.text = remedy.type ?? '';
    //     descriptionController.text = remedy.description!;

    //     //
    //     var value = await ApiImage.getImage(remedy.cover!);
    //     if (value != null) {
    //       coverImage.value = FormImageModel(
    //         name: value.file_name,
    //         bytes: value.image_data,
    //       );
    //     } else {
    //       coverImage.value = null;
    //     }

    //     //
    //     if (remedy.images != null) {
    //       for (var i = 0; i < remedy.images!.length; i++) {
    //         print(remedy.images![i].path);
    //         var value = await ApiImage.getImage(remedy.images![i].path!);
    //         if (value != null) {
    //           otherImages.add(
    //             FormImageModel(
    //               id: remedy.images![i].id,
    //               name: value.file_name,
    //               bytes: value.image_data,
    //             ),
    //           );
    //         }
    //       }
    //     }

    //     //

    //     if (remedy.treatments != null) {
    //       for (var ailment in remedy.treatments!) {
    //         print(ailment.name);
    //         ailments.add(ailment);
    //       }
    //     }

    //     //
    //     if (remedy.steps != null) {
    //       for (var i = 0; i < remedy.steps!.length; i++) {
    //         steps.add(remedy.steps![i]);
    //       }
    //     }

    //     if (remedy.ingredients != null) {
    //       for (var i = 0; i < remedy.ingredients!.length; i++) {
    //         ingredients.add(remedy.ingredients![i]);
    //       }
    //     }

    //     if (remedy.usages != null) {
    //       for (var i = 0; i < remedy.usages!.length; i++) {
    //         usages.add(remedy.usages![i]);
    //       }
    //     }
    //   }

    //   //
    // } catch (e) {
    //   printError(info: e.toString());
    // }

    setState();
  }

  void exitEditMode() {
    isEditMode.value = false;
    SessionRemedy.removeEditRemedy();
  }

  void cancelModalWarning() {
    if (nameController.text.isEmpty &&
        typeController.text.isEmpty &&
        descriptionController.text.isEmpty &&
        coverImage.value == null &&
        otherImages.value.isEmpty &&
        ailments.isEmpty &&
        usages.isEmpty &&
        steps.isEmpty &&
        usages.isEmpty &&
        plantDropdownController.value.dropDownValue == null) {
      Get.offNamed(CustomRoute.path.remediesTable);
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
            Get.offNamed(CustomRoute.path.remediesTable);
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

    if (steps.isEmpty) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Steps',
        'Please add at least one steps.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return;
    }

    if (usages.isEmpty) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Usages',
        'Please add at least one usages.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return;
    }
    if (ingredients.isEmpty) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Ingredient',
        'Please add at least one ingredient.',
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
              text: 'You are about to upload a new remedy.',
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

    if (steps.isEmpty) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Steps',
        'Please add at least one steps.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return;
    }

    if (usages.isEmpty) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Usages',
        'Please add at least one usages.',
        backgroundColor: const Color(0xFFFFD4D4),
        colorText: Colors.black,
      );
      return;
    }
    if (ingredients.isEmpty) {
      Get.snackbar(
        padding: const EdgeInsets.all(10),
        'Ingredient',
        'Please add at least one ingredient.',
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
              text: 'You are about to update a new remedy.',
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

  //
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

  // =============================

  void submitForm() async {
    var user = await SessionAccess.instance.getSessionData();
    PlantModel plant = plantDropdownController.value.dropDownValue!.value;
    progressMessage.value = 'Uploading remedy basic info...';

    loadingModal(title: 'Uploading');

    try {
      var remedy = RemedyModel(
        name: nameController.text,
        type: typeController.text,
        description: descriptionController.text,
        plant_id: plant.id,
        create_by: user,
      );

      ResponseModel response = await ApiRemedy.uploadRemedy(remedy: remedy);

      if (response.success == false || response.errors != null) {
        Get.close(1);
        failedModal(
          title: 'Failed',
          subtitle: 'Failed to create remedy',
        );
        return;
      }

      if (response.clientError ?? false) {
        Get.close(1);
        failedModal(
          title: 'Failed',
          subtitle: response.message,
        );
        return;
      }

      var remedyUploaded = RemedyModel.fromJson(response.data!);

      progressMessage.value = 'Uploading ingredients...';

      for (var ingredient in ingredients) {
        var response = await ApiRemedy.uploadIngredient(
          ingredient: IngredientModel(
            remedy_id: remedyUploaded.id,
            name: ingredient.name,
            description: ingredient.description,
          ),
        );

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to create ingredient',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Ingredient uploaded successfully');
      }

      progressMessage.value = 'Uploading treatments...';

      for (var treatment in ailments) {
        var response = await ApiRemedy.uploadTeatment(
          treatment: RemedyTreatmentModel(
            remedy_id: remedyUploaded.id,
            name: treatment.name,
            description: treatment.description,
          ),
        );

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to create treatment',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Treatment uploaded successfully');
      }

      progressMessage.value = 'Uploading steps...';

      for (var step in steps) {
        var response = await ApiRemedy.uploadStep(
          step: StepModel(
            remedy_id: remedyUploaded.id,
            name: step.name,
            description: step.description,
          ),
        );

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to create step',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Step uploaded successfully');
      }

      progressMessage.value = 'Uploading usages...';

      for (var usage in usages) {
        var response = await ApiRemedy.uploadUsage(
          usage: UsageModel(
            remedy_id: remedyUploaded.id,
            name: usage.name,
            description: usage.description,
          ),
        );

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to create usage',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Usage uploaded successfully');
      }

      progressMessage.value = 'Uploading remedies images...';

      if (coverImage.value != null) {
        var response =
            await ApiRemedy.uploadCover(remedyUploaded, coverImage.value!);
        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to upload cover image',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Cover image uploaded successfully');
      }

      //

      for (var image in otherImages) {
        var response = await ApiRemedy.uploadImage(remedyUploaded, image);
        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to upload image',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Image uploaded successfully');
      }

      Get.close(1);
      successModal(
        title: 'Success',
        subtitle: 'Remedy created successfully',
      );
    } catch (e) {
      print(e);
    }
  }

  //

  void updateForm() async {
    var user = await SessionAccess.instance.getSessionData();
    PlantModel plant = plantDropdownController.value.dropDownValue!.value;

    progressMessage.value = 'Updating remedy basic info...';
    loadingModal(title: 'Updating');

    try {
      //for update
      var oldRemedy = await SessionRemedy.getEditRemedy();

      var remedy = RemedyModel(
        id: oldRemedy!.id,
        name: nameController.text,
        type: typeController.text,
        description: descriptionController.text,
        plant_id: plant.id,
        update_by: user,
        create_by: user,
      );

      ResponseModel response = await ApiRemedy.updateRemedy(remedy: remedy);

      if (response.success == false || response.errors != null) {
        Get.close(1);
        failedModal(
          title: 'Failed',
          subtitle: 'Failed to Updated remedy',
        );
        return;
      }

      if (response.clientError ?? false) {
        Get.close(1);
        failedModal(
          title: 'Failed',
          subtitle: response.message,
        );
        return;
      }

      progressMessage.value = 'Updating ingredients...';
      await ApiRemedy.clearIngredient(remedyID: oldRemedy.id!);

      for (var ingredient in ingredients) {
        var response = await ApiRemedy.uploadIngredient(
          ingredient: IngredientModel(
            remedy_id: oldRemedy.id,
            name: ingredient.name,
            description: ingredient.description,
          ),
        );

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to Update ingredient',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Ingredient Updated successfully');
      }

      progressMessage.value = 'Updating treatments...';
      await ApiRemedy.clearTreatments(id: oldRemedy.id!);

      for (var treatment in ailments) {
        var response = await ApiRemedy.uploadTeatment(
          treatment: RemedyTreatmentModel(
            remedy_id: oldRemedy.id,
            name: treatment.name,
            description: treatment.description,
          ),
        );

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to Update treatment',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Treatment Updated successfully');
      }

      progressMessage.value = 'Updating steps...';
      await ApiRemedy.clearSteps(remedyId: oldRemedy.id!);

      for (var step in steps) {
        var response = await ApiRemedy.uploadStep(
          step: StepModel(
            remedy_id: oldRemedy.id,
            name: step.name,
            description: step.description,
          ),
        );

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to Update step',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Step Updated successfully');
      }

      progressMessage.value = 'Updating usages...';
      await ApiRemedy.clearUsages(remedyId: oldRemedy.id!);

      for (var usage in usages) {
        var response = await ApiRemedy.uploadUsage(
          usage: UsageModel(
            remedy_id: oldRemedy.id,
            name: usage.name,
            description: usage.description,
          ),
        );

        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to Updated usage',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Usage Updated successfully');
      }

      progressMessage.value = 'Updating remedy images...';
      await ApiRemedy.clearImages(remedy: oldRemedy);

      if (coverImage.value != null) {
        var response =
            await ApiRemedy.uploadCover(oldRemedy, coverImage.value!);
        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to Update cover image',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Cover image Updated successfully');
      }

      //

      await ApiRemedy.clearImages(remedy: oldRemedy);
      for (var image in otherImages) {
        var response = await ApiRemedy.uploadImage(oldRemedy, image);
        if (response.success == false || response.errors != null) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: 'Failed to upload image',
          );
          return;
        }

        if (response.clientError ?? false) {
          Get.close(1);
          failedModal(
            title: 'Failed',
            subtitle: response.message,
          );
          return;
        }

        print('Image Updated successfully');
      }

      Get.close(1);
      successModal(title: 'Success', subtitle: 'Remedy updated successfully');
    } catch (e) {
      print(e);
    }
  }
}
