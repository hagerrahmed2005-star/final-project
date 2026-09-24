import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_text_style.dart';
import 'package:todo/features/add%20task/model/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 25,
              decoration: BoxDecoration(
                color:Color(task.color),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(task.title, style: AppTextStyle.headlineStyle),
                  Text(
                    task.description,
                    style: AppTextStyle.bodyMediumStyle.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(task.color).withAlpha(30),
                    ),
                    child: Text(
                      task.status,
                      style: AppTextStyle.bodyMediumStyle.copyWith(
                        color:  Color(task.color),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 30),
          ],
        ),
      ),
    );
  }
}
