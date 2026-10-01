# Nexus Life

**Prywatny, offline-first asystent AI do organizowania cyfrowego życia**

Nexus Life to aplikacja **Flutter** działająca na **iOS i Android**.  
Wszystkie dane pozostają na urządzeniu. AI działa lokalnie (on-device).

## Główna idea

- Mówisz naturalnym językiem → AI tworzy wydatki, wydarzenia, nawyki, notatki
- Skanujesz paragony / zdjęcia → automatyczna kategoryzacja i wyszukiwanie
- Zero utraty danych, zero crashy, pełna prywatność
- Jeden dashboard z tym, co ważne dzisiaj

## Status projektu

🚀 **MVP w budowie** (październik 2026)  
**Cel główny: iPhone (iOS)**

### Stack
- **Flutter** (iOS first + Android)
- Lokalna baza: **Isar**
- Voice: `speech_to_text` (działa na iOS i Android)
- UI: Material 3

## Jak uruchomić na iPhone

### Wymagania
- Mac z Xcode (najnowszy)
- Flutter SDK
- Apple Developer Account (darmowy wystarczy do testowania na własnym iPhonie)

### Kroki

```bash
# 1. Sklonuj projekt
git clone https://github.com/Benek2616/nexus-life.git
cd nexus-life

# 2. Utwórz foldery platform (jeśli ich jeszcze nie ma)
flutter create . --platforms=ios,android

# 3. Zainstaluj zależności
flutter pub get

# 4. Wygeneruj kod Isar
flutter pub run build_runner build --delete-conflicting-outputs

# 5. Podłącz iPhone kablem i zaufaj komputerowi

# 6. Uruchom na iPhonie
flutter run
```

### Uprawnienia iOS (Info.plist)
Po `flutter create` dodaj w pliku `ios/Runner/Info.plist`:

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Aplikacja potrzebuje mikrofonu do rozpoznawania mowy</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Aplikacja używa rozpoznawania mowy, żeby zapisywać wydatki i notatki głosem</string>
```

## Roadmapa MVP (v0.1)

- [x] Struktura Flutter + modele
- [x] Lokalna baza Isar
- [x] VoiceService (polski)
- [x] Dashboard + zapisywanie wydatków głosem
- [ ] Pełna konfiguracja iOS (Info.plist + uprawnienia)
- [ ] Lista wydatków i nawyków
- [ ] Lepsze rozpoznawanie intencji

## Link do repozytorium
https://github.com/Benek2616/nexus-life

---

**Repozytorium stworzone automatycznie przez Grok** • 1 października 2026
