import 'package:get/get.dart';
import 'package:taskmanager/data/Api/api_service.dart';
import 'package:taskmanager/data/models/task_model.dart';

class DashboardController extends GetxController {
  final ApiService _apiService = ApiService();

  RxBool isLoading = false.obs;
  RxList<TaskItem> tasks = <TaskItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    try {
      isLoading.value = true;

      final data = await _apiService.getTodos();
      tasks.assignAll(data);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load tasks',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Toggle Completed <-> Pending
  void toggleTaskStatus(TaskItem task) {
    final index = tasks.indexWhere((e) => e.id == task.id);

    if (index != -1) {
      tasks[index] = TaskItem(
        userId: task.userId,
        id: task.id,
        title: task.title,
        completed: !task.completed,
      );

      // Notify GetX that the list has changed
      tasks.refresh();
    }
  }
}
