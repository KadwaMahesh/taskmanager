import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastmanager/controllers/dashbord_controller.dart';
import 'package:tastmanager/data/models/task_model.dart';
import 'package:tastmanager/widgets/app_color.dart';
import 'package:tastmanager/widgets/app_text_style.dart';
import 'package:tastmanager/widgets/search_textfield.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.put(DashboardController());

  final TextEditingController searchController = TextEditingController();

  int selectedFilterIndex = 0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<TaskItem> get filteredTasks {
    final query = searchController.text.trim().toLowerCase();

    return controller.tasks.where((task) {
      final matchesQuery =
          query.isEmpty || task.title.toLowerCase().contains(query);

      final matchesFilter = switch (selectedFilterIndex) {
        1 => !task.completed,
        2 => task.completed,
        _ => true,
      };

      return matchesQuery && matchesFilter;
    }).toList();
  }

  void logout() {
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pageBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Tasks", style: AppTextStyle.subheadingStyle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.pageBackgroundColor,
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchTextField(
                controller: searchController,
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ),

            const SizedBox(height: 20),

            /// Filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  buildFilterChip("All", 0),
                  const SizedBox(width: 10),
                  buildFilterChip("Pending", 1),
                  const SizedBox(width: 10),
                  buildFilterChip("Completed", 2),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tasks = filteredTasks;

                if (tasks.isEmpty) {
                  return const Center(child: Text("No Tasks Found"));
                }

                return RefreshIndicator(
                  onRefresh: controller.fetchTodos,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: tasks.length,
                    itemBuilder: (_, index) {
                      return buildTaskCard(tasks[index]);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterChip(String text, int index) {
    final selected = selectedFilterIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilterIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? AppColor.primaryColor.withOpacity(0.1)
              : AppColor.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColor.primaryColor : AppColor.borderColor,
          ),
        ),
        child: Row(
          children: [
            if (selected)
              const Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: AppColor.primaryColor,
                ),
              ),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? AppColor.primaryColor : AppColor.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTaskCard(TaskItem task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ID Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("User : ${task.userId}", style: AppTextStyle.bodyStyle),
              Text("ID : ${task.id}", style: AppTextStyle.bodyStyle),
            ],
          ),

          const SizedBox(height: 12),

          /// Title
          Text(task.title, style: AppTextStyle.subheadingStyle),

          const SizedBox(height: 16),

          /// Status Button
          GestureDetector(
            onTap: () {
              controller.toggleTaskStatus(task);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: task.completed
                    ? AppColor.completedTaskColor
                    : AppColor.pendingTaskColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                task.completed ? "Completed" : "Pending",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: task.completed
                      ? AppColor.greenColor
                      : AppColor.redColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
