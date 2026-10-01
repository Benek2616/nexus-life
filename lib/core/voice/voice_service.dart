import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _lastWords = '';

  bool get isListening => _isListening;
  String get lastWords => _lastWords;

  Future<bool> initialize() async {
    return await _speech.initialize(
      onStatus: (status) {
        _isListening = status == 'listening';
      },
      onError: (error) {
        print('Voice error: $error');
        _isListening = false;
      },
    );
  }

  Future<void> startListening({required Function(String) onResult}) async {
    if (!_speech.isAvailable) {
      final available = await initialize();
      if (!available) return;
    }

    _isListening = true;
    await _speech.listen(
      onResult: (result) {
        _lastWords = result.recognizedWords;
        onResult(_lastWords);
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      localeId: 'pl_PL', // Polski od razu
      cancelOnError: true,
      partialResults: true,
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
    _isListening = false;
  }

  /// Prosta regułowa interpretacja głosu (MVP – później zamienimy na lokalne AI)
  static Map<String, dynamic>? parseCommand(String text) {
    final lower = text.toLowerCase().trim();

    // Wydatki
    final expenseRegex = RegExp(r'(wydałem|zapłaciłem|kupiłem|kosztowało|wydatek)\s+.*?(\d+[.,]?\d*)\s*(zł|pln|zlotych)?');
    final match = expenseRegex.firstMatch(lower);
    if (match != null) {
      final amountStr = match.group(2)?.replaceAll(',', '.') ?? '0';
      final amount = double.tryParse(amountStr) ?? 0;
      return {
        'type': 'expense',
        'amount': amount,
        'title': text,
      };
    }

    // Nawyki
    if (lower.contains('zrobiłem') || lower.contains('ukończyłem') || lower.contains('zaliczyłem')) {
      return {
        'type': 'habit_complete',
        'text': text,
      };
    }

    // Notatka (fallback)
    return {
      'type': 'note',
      'content': text,
    };
  }
}
