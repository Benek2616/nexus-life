import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'models.dart';

class DatabaseService {
  static late final Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        ExpenseSchema,
        HabitSchema,
        NoteSchema,
        EventSchema,
      ],
      directory: dir.path,
      name: 'nexus_life',
    );
  }

  // ========== EXPENSES ==========
  static Future<void> addExpense(Expense expense) async {
    await isar.writeTxn(() async {
      await isar.expenses.put(expense);
    });
  }

  static Future<List<Expense>> getExpenses({DateTime? from, DateTime? to}) async {
    final query = isar.expenses.where();
    // Proste filtrowanie – później rozbudujemy
    return await query.findAll();
  }

  static Future<double> getTotalExpensesToday() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final expenses = await isar.expenses
        .filter()
        .dateGreaterThan(startOfDay, include: true)
        .findAll();
    return expenses.fold(0.0, (sum, e) => sum + e.amount);
  }

  // ========== HABITS ==========
  static Future<void> addHabit(Habit habit) async {
    await isar.writeTxn(() async {
      await isar.habits.put(habit);
    });
  }

  static Future<List<Habit>> getActiveHabits() async {
    return await isar.habits.filter().isArchivedEqualTo(false).findAll();
  }

  static Future<void> completeHabit(int habitId) async {
    await isar.writeTxn(() async {
      final habit = await isar.habits.get(habitId);
      if (habit != null) {
        habit.completedDates.add(DateTime.now());
        await isar.habits.put(habit);
      }
    });
  }

  // ========== NOTES ==========
  static Future<void> addNote(Note note) async {
    await isar.writeTxn(() async {
      await isar.notes.put(note);
    });
  }

  static Future<List<Note>> getNotes() async {
    return await isar.notes.where().sortByCreatedAtDesc().findAll();
  }

  // ========== EVENTS ==========
  static Future<void> addEvent(Event event) async {
    await isar.writeTxn(() async {
      await isar.events.put(event);
    });
  }

  static Future<List<Event>> getEventsToday() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = start.add(const Duration(days: 1));
    return await isar.events
        .filter()
        .startBetween(start, end)
        .findAll();
  }
}
