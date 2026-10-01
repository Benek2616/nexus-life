# Tech Stack – Nexus Life

## Core

| Warstwa              | Technologia                          | Dlaczego                                      |
|----------------------|--------------------------------------|-----------------------------------------------|
| Framework            | Flutter 3.24+                        | Szybki development, jeden kod na Android+iOS |
| Język                | Dart                                 | Native dla Fluttera                           |
| UI                   | Material 3 + custom components       | Nowoczesny, spójny wygląd                    |
| State management     | Riverpod 2.x                         | Prosty, testowalny, skalowalny                |
| Lokalna baza         | Isar                                 | Bardzo szybka, offline-first, łatwy export   |
| On-device AI         | Google AI Edge / Gemini Nano + MediaPipe | Najlepsza jakość na Androidzie w 2026     |
| Speech-to-text       | Android SpeechRecognizer + lokalne NLP | Zero chmury                                   |
| OCR                  | ML Kit Text Recognition (on-device)   | Szybki i prywatny                             |
| Backup               | Zaszyfrowany export (AES) + opcjonalny cloud | Pełna kontrola użytkownika              |

## Architektura

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── database/
│   ├── ai/
│   ├── voice/
│   └── theme/
├── features/
│   ├── dashboard/
│   ├── voice_capture/
│   ├── expenses/
│   ├── habits/
│   ├── notes/
│   └── scanner/
└── shared/
```

## Priorytety techniczne

1. **Nigdy nie gub danych** – każda operacja ma lokalny commit + opcjonalny export
2. **Offline first** – aplikacja musi działać bez internetu w 100%
3. **Szybkość** – dashboard ładuje się < 300 ms
4. **Prywatność** – żadnych telemetrii bez zgody, żadnych danych poza urządzeniem
