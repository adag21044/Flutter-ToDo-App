import 'package:flutter/material.dart'; // Import the Flutter material package for building UI.
import 'package:to_do/constants/colors.dart'; // Import custom color constants for consistent styling.

// This is the main Home widget which will be the main screen of the To-Do app.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState(); // Create the mutable state for the Home widget.
}

// This is the state class for the Home widget.
class _HomeState extends State<Home> {
  // A list to hold tasks, where each task is represented by a map.
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController(); // Controller to manage the text input.

  // Method to add a new task to the list.
  void _addTask(String task) {
    // Check if the input task is not empty.
    if (task.isNotEmpty) {
      setState(() {
        // Add a new task to the list with initial completion status set to false.
        _tasks.add({'task': task, 'isCompleted': false});
      });
      _controller.clear(); // Clear the input field after adding the task.
    }
  }

  // Method to toggle the completion status of a task.
  void _toggleTaskCompletion(int index) {
    setState(() {
      // Toggle the 'isCompleted' status of the task at the specified index.
      _tasks[index]['isCompleted'] = !_tasks[index]['isCompleted'];
    });
  }

  // Method to delete a task from the list.
  void _deleteTask(int index) {
    setState(() {
      // Remove the task at the specified index from the list.
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the UI for the Home widget.
    return Scaffold(
      backgroundColor: tdBGC, // Set the background color of the Scaffold.
      appBar: buildAppBar(), // Call the function to create the AppBar.
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the body.
        child: Column(
          children: [
            // Task Input Area
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color for the input container.
                borderRadius: BorderRadius.circular(20), // Rounded corners for the container.
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, // Shadow color.
                    blurRadius: 10, // Blur effect for the shadow.
                    spreadRadius: 1, // Spread radius for the shadow.
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16), // Padding for the input field.
              child: TextField(
                controller: _controller, // Connect the TextField to the controller.
                decoration: const InputDecoration(
                  border: InputBorder.none, // No border for the TextField.
                  hintText: 'Add a new task', // Placeholder text for the input.
                ),
                onSubmitted: (value) {
                  _addTask(value); // Call the method to add the task when submitted.
                },
              ),
            ),
            const SizedBox(height: 20), // Add space between input and the task list.

            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length, // Number of tasks to display.
                itemBuilder: (context, index) {
                  final task = _tasks[index]; // Get the task at the current index.
                  return TaskItem(
                    task: task['task'], // Pass the task description.
                    isCompleted: task['isCompleted'], // Pass the completion status.
                    onToggle: () => _toggleTaskCompletion(index), // Pass the toggle method.
                    onDelete: () => _deleteTask(index), // Pass the delete method.
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build the AppBar.
  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: tdBGC, // Set AppBar background color.
      elevation: 0, // No shadow for the AppBar.
      title: const Text(
        'To-Do List', // Title of the AppBar.
        style: TextStyle(
          color: tdBlack, // Title text color.
          fontWeight: FontWeight.bold, // Bold text.
          fontSize: 24, // Font size.
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: tdBlack), // Settings icon button.
          onPressed: () {}, // Do nothing for now.
        )
      ],
    );
  }
}

// TaskItem Widget: This widget represents a single task item in the list.
class TaskItem extends StatelessWidget {
  final String task; // The task description.
  final bool isCompleted; // Whether the task is completed.
  final VoidCallback onToggle; // Callback function to toggle completion status.
  final VoidCallback onDelete; // Callback function to delete the task.

  const TaskItem({super.key, 
    required this.task,
    required this.isCompleted,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8), // Margin for spacing between task items.
      padding: const EdgeInsets.all(16), // Padding inside the task item.
      decoration: BoxDecoration(
        color: isCompleted ? Colors.grey.shade200 : Colors.white, // Change background based on completion.
        borderRadius: BorderRadius.circular(15), // Rounded corners for the task item.
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300, // Shadow color for the task item.
            blurRadius: 6, // Blur effect for the shadow.
            offset: const Offset(0, 2), // Offset for the shadow.
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between items in the row.
        children: [
          GestureDetector(
            onTap: onToggle, // Toggle completion status when tapped.
            child: Row(
              children: [
                Icon(
                  isCompleted ? Icons.check_circle : Icons.circle_outlined, // Show check or circle based on completion.
                  color: isCompleted ? tdRed : tdBlack, // Color of the icon.
                ),
                const SizedBox(width: 10), // Space between the icon and task text.
                Text(
                  task, // Display the task description.
                  style: TextStyle(
                    fontSize: 16, // Font size for the task text.
                    decoration: isCompleted
                        ? TextDecoration.lineThrough // Strike through if completed.
                        : TextDecoration.none, // No decoration if not completed.
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: tdRed), // Delete icon button.
            onPressed: onDelete, // Call delete function when pressed.
          ),
        ],
      ),
    );
  }
}
