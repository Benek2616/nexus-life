# Nexus Life

**Prywatny, offline-first asystent AI do organizowania cyfrowego życia**

Nexus Life to aplikacja Android (docelowo iOS), która działa jako osobisty system operacyjny życia użytkownika. Wszystkie dane pozostają na urządzeniu. AI działa lokalnie (on-device).

## Główna idea

- Mówisz naturalnym językiem → AI tworzy wydatki, wydarzenia, nawyki, notatki
- Skanujesz paragony / zdjęcia → automatyczna kategoryzacja i wyszukiwanie
- Zero utraty danych, zero crashy, pełna prywatność
- Jeden dashboard z tym, co ważne dzisiaj

## Status projektu

🚀 **MVP w budowie** (październik 2026)

Aktualny stack planowany:
- **Flutter** (Android first, później iOS)
- Lokalna baza: **Isar** lub **Drift**
- On-device AI: Gemini Nano / MediaPipe / lokalne modele (Llama / Gemma)
- Voice: Android SpeechRecognizer + lokalne NLP
- UI: Material 3 + custom dashboard

## Roadmapa MVP (v0.1)

- [ ] Podstawowy voice → struktura (wydatki + wydarzenia)
- [ ] Lokalna baza danych + backup/export
- [ ] Prosty dashboard (dziś)
- [ ] Skaner paragonów (OCR lokalny)
- [ ] System nawyków
- [ ] Tryb offline 100%

## Dlaczego to może być hit?

1. Ludzie mają chaos z wieloma AI i aplikacjami
2. Android ma słabą średnią jakość aplikacji (crashe, utrata danych)
3. Prywatność staje się kluczowym argumentem sprzedażowym
4. Subskrypcja 19–39 zł/mies. ma bardzo dobry potencjał

## Jak uruchomić (wkrótce)

```bash
git clone https://github.com/Benek2616/nexus-life.git
cd nexus-life
flutter pub get
flutter run
```

## Licencja

MIT (na razie)

---

**Repozytorium stworzone automatycznie przez Grok** • 1 października 2026
