import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/app_bottom.dart';
import 'package:todo/core/theme/app_text_style.dart';
import 'package:todo/core/utils/app_constant.dart';
import 'package:todo/core/widgets/custom_text_form_feild.dart';
import 'package:todo/features/add%20task/model/task_model.dart';
import 'package:todo/features/add%20task/widgets/task_color_list_view.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  int? Color;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                CustomTextFormFeild(
                  controller: titleController,
                  title: "Task Title",
                  hintText: "Design Login Screen",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Task Title is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                CustomTextFormFeild(
                  controller: descriptionController,
                  title: "Description",
                  hintText: "Task Description",
                  maxlines: 6,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormFeild(
                  controller: dateController,
                  title: "Task Date",
                  hintText: "Enter Date",
                  readonly: true,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2028),
                    ).then((valu) {
                      dateController.text = DateFormat.LLLL().format(
                        valu ?? DateTime.now(),
                      );
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "date is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text("Choose Color", style: AppTextStyle.bodyMediumStyle),
                TaskColorListView(
                  onvalue: (c) {
                    Color = c?.toARGB32();
                  },
                ),
                SizedBox(height: 20),
                AppBottom(
                  title: "Save Task",
                  onTap: () {
                    if (Color == null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("error"),
                          content: Text("please choose color"),
                        ),
                      );
                      return;
                    }
                    if (formKey.currentState?.validate() ?? false) {
                      Hive.box<TaskModel>(AppConstant.TaskBox)
                          .add(
                            TaskModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: dateController.text,
                              color: Color!,
                            ),
                          )
                          .then((value) {
                            Navigator.pop(context);
                          });
                    }
                    ;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
