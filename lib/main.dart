import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/database/database_service.dart';
import 'core/voice/voice_service.dart';
import 'core/database/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init();
  runApp(
    const ProviderScope(
      child: NexusLifeApp(),
    ),
  );
}

class NexusLifeApp extends StatelessWidget {
  const NexusLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nexus Life',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A73E8),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A73E8),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VoiceService _voice = VoiceService();
  String _status = 'Gotowy';
  String _lastResult = '';
  bool _isListening = false;
  double _todayExpenses = 0;

  @override
  void initState() {
    super.initState();
    _loadTodayExpenses();
  }

  Future<void> _loadTodayExpenses() async {
    final total = await DatabaseService.getTotalExpensesToday();
    setState(() => _todayExpenses = total);
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      await _voice.stopListening();
      setState(() {
        _isListening = false;
        _status = 'Przetwarzam...';
      });

      // Parsuj i zapisz
      final parsed = VoiceService.parseCommand(_lastResult);
      if (parsed != null) {
        await _handleParsedCommand(parsed);
      }

      setState(() => _status = 'Gotowy');
    } else {
      setState(() {
        _isListening = true;
        _status = 'Słucham...';
        _lastResult = '';
      });

      await _voice.startListening(
        onResult: (text) {
          setState(() => _lastResult = text);
        },
      );
    }
  }

  Future<void> _handleParsedCommand(Map<String, dynamic> data) async {
    final type = data['type'];

    if (type == 'expense') {
      final expense = Expense(
        title: data['title'] ?? 'Wydatek',
        amount: (data['amount'] as num).toDouble(),
        date: DateTime.now(),
        category: 'Inne',
      );
      await DatabaseService.addExpense(expense);
      await _loadTodayExpenses();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Dodano wydatek: ${expense.amount.toStringAsFixed(2)} zł'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else if (type == 'note') {
      final note = Note(content: data['content'] ?? '');
      await DatabaseService.addNote(note);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Zapisano notatkę'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nexus Life'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dashboard header
              Text(
                'Dziś',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),

              // Karty podsumowania
              Row(
                children: [
                  Expanded(
                    child: _SummaryCard(
                      title: 'Wydatki',
                      value: '${_todayExpenses.toStringAsFixed(0)} zł',
                      icon: Icons.payments_outlined,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _SummaryCard(
                      title: 'Nawyki',
                      value: '0/3',
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Status głosu
              Center(
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _isListening ? 120 : 80,
                      height: _isListening ? 120 : 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isListening
                            ? Colors.red.withOpacity(0.15)
                            : Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        size: _isListening ? 48 : 36,
                        color: _isListening
                            ? Colors.red
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _status,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (_lastResult.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        _lastResult,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ],
                ),
              ),

              const Spacer(),

              // Przycisk główny
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: _toggleListening,
                  icon: Icon(_isListening ? Icons.stop : Icons.mic),
                  label: Text(_isListening ? 'Zatrzymaj' : 'Powiedz coś'),
                  style: FilledButton.styleFrom(
                    backgroundColor: _isListening ? Colors.red : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
