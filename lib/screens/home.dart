import 'package:flutter/material.dart';
import 'package:to_do/constants/colors.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _tasks.add({'task': task, 'isCompleted': false});
      });
      _controller.clear();
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted'];
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGC,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Görev Ekleme Alanı
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add a new task',
                ),
                onSubmitted: (value) {
                  _addTask(value);
                },
              ),
            ),
            SizedBox(height: 20),

            // Görev Listesi
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return TaskItem(
                    task: task['task'],
                    isCompleted: task['isCompleted'],
                    onToggle: () => _toggleTaskCompletion(index),
                    onDelete: () => _deleteTask(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // AppBar Fonksiyonu
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBGC,
      elevation: 0,
      title: Text(
        'To-Do List',
        style: TextStyle(
          color: tdBlack,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings, color: tdBlack),
          onPressed: () {},
        )
      ],
    );
  }
}

// TaskItem Widget'ı: Görevleri listeler
class TaskItem extends StatelessWidget {
  final String task;
  final bool isCompleted;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskItem({
    required this.task,
    required this.isCompleted,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.grey.shade200 : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Row(
              children: [
                Icon(
                  isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  color: isCompleted ? tdRed : tdBlack,
                ),
                SizedBox(width: 10),
                Text(
                  task,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: tdRed),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
