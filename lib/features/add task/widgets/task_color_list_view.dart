import 'package:flutter/material.dart';

class TaskColorListView extends StatefulWidget {
  final Function(Color?) onvalue;
  TaskColorListView( {super.key, required this.onvalue});

  @override
  State<TaskColorListView> createState() => _TaskColorListViewState();
}

class _TaskColorListViewState extends State<TaskColorListView> {

  List<Color> tasksColor = [
    const Color.fromARGB(255, 82, 10, 5),
    const Color.fromARGB(255, 245, 220, 2),
    const Color.fromARGB(255, 209, 126, 2),
    const Color.fromARGB(255, 5, 137, 10),
    const Color.fromARGB(255, 5, 117, 208),
    const Color.fromARGB(255, 82, 29, 9),
    const Color.fromARGB(255, 128, 0, 128),
  ];

  int activeindex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tasksColor.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              activeindex = index;
              widget.onvalue(tasksColor[index]);
            });
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: tasksColor[index],
            child: activeindex == index
                ? const Center(child: Icon(Icons.check, color: Colors.white))
                : null,
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
      ),
    );
  }
}
