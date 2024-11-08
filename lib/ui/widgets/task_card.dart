import 'package:flutter/material.dart';
import 'package:task_management_app/data/models/task_model.dart';
import 'package:task_management_app/ui/utils/app_colors.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleSmall,
            ),
            Text(
              widget.taskModel.description ?? '',
            ),
            Text(
              'Date: ${widget.taskModel.createdDate ?? ''}',
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatusChip(),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: _onTapEditButton,
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: _onTapDeleteButton,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTapEditButton() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text('Edit Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['New', 'Completed', 'Cancelled', 'Progress'].map((e){
            return ListTile(
              onTap: (){},
              title: Text(e),
            );
          }).toList(),
        ),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Cancel'),),
          TextButton(onPressed: () {}, child: const Text('Save'),),
        ],
      );
    });
  }

  void _onTapDeleteButton() {
    // TODO: on Tap delete task
  }

  Widget _buildTaskStatusChip() {
    return Chip(
      label: const Text('New'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: const BorderSide(
        color: AppColors.themeColor,
      ),
    );
  }
}
