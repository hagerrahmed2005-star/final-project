import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/theme/app_color.dart';
import 'package:todo/core/theme/app_text_style.dart';
import 'package:todo/core/utils/app_constant.dart';
import 'package:todo/features/home/auth/ui/widgets/task_states_card.dart'; 
import 'package:todo/features/add%20task/model/task_model.dart';
import 'package:todo/features/add%20task/ui/add_task_screen.dart';
import 'package:todo/features/home/auth/ui/widgets/home_app_bar.dart';
import 'package:todo/features/home/auth/ui/widgets/tasks_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  late Box<TaskModel> taskBox;
  @override
  void initState() {
    super.initState();
    taskBox = Hive.box<TaskModel>(AppConstant.TaskBox); 
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: taskBox.listenable(), 
      builder: (context, Box<TaskModel> box, _) {
        List<TaskModel> tasksList = box.values.toList();
        final int total = tasksList.length;
        final int completed = tasksList.where((task) =>
         task.status.toLowerCase() == 'done' ||
          task.status.toLowerCase() == 'completed').length;
        final int pending = tasksList.where((task) => task.status.toLowerCase() == 'pending').length;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeAppBar(),
                  const SizedBox(height: 20),
                  TaskStatesCard(
                    totalTasks: total,
                    completedTasks: completed,
                    pendingTasks: pending,
                  ),
                  
                  const SizedBox(height: 20),

                  Text("Today is Tasks", style: AppTextStyle.headlineStyle),
                  const SizedBox(height: 12),
                  
                  const Expanded(
                    child: TasksListView(),
                  ),
                ],
              ),
            ),
          ),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()),
              );
            },
            backgroundColor: AppColor.primaryColor,
            focusColor: Colors.white,
            label: Row(
              children: [
                const Icon(Icons.add, color: Colors.white),
                Text(
                  "Task",
                  style: AppTextStyle.bodylargeStyle.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}