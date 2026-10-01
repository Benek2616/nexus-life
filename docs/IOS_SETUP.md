# Uruchomienie Nexus Life na iPhone

## Szybka ścieżka

1. Na Macu otwórz Terminal
2. Wykonaj:

```bash
git clone https://github.com/Benek2616/nexus-life.git
cd nexus-life
flutter create . --platforms=ios,android
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Otwórz plik `ios/Runner/Info.plist` i dodaj na końcu (przed `</dict>`):

```xml
<key>NSMicrophoneUsageDescription</key>
<string>Aplikacja potrzebuje mikrofonu, żeby rozpoznawać mowę i zapisywać wydatki oraz notatki głosem.</string>
<key>NSSpeechRecognitionUsageDescription</key>
<string>Aplikacja używa rozpoznawania mowy Apple, żeby automatycznie tworzyć wydatki, nawyki i notatki.</string>
```

4. Podłącz iPhone kablem USB, odblokuj i kliknij "Zaufaj temu komputerowi".

5. Uruchom:

```bash
flutter run
```

Lub otwórz `ios/Runner.xcworkspace` w Xcode i odpal stamtąd (wygodniejsze do podpisywania).

## Ważne uwagi

- Do testowania na własnym iPhonie wystarczy darmowe Apple ID.
- Przy pierwszym uruchomieniu Xcode poprosi o wybranie Team (Twoje Apple ID).
- Rozpoznawanie mowy na iOS działa bardzo dobrze i jest w pełni lokalne (Apple Speech).
- Isar też działa natywnie na iOS.

## Problemy?

Jeśli coś nie działa – napisz, to poprawimy.
