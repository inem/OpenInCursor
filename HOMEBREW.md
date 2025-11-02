# Добавление Open in Cursor в Homebrew

## Создание Cask файла

Cask файл уже создан: `Casks/open-in-cursor.rb`

## Процесс добавления в Homebrew

1. **Форкните репозиторий Homebrew Cask:**
   ```bash
   gh repo fork Homebrew/homebrew-cask
   ```

2. **Клонируйте ваш форк:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/homebrew-cask.git
   cd homebrew-cask
   ```

3. **Скопируйте cask файл:**
   ```bash
   cp /path/to/OpenInCursor/Casks/open-in-cursor.rb Casks/
   ```

4. **Создайте ветку и закоммитьте:**
   ```bash
   git checkout -b add-open-in-cursor
   git add Casks/open-in-cursor.rb
   git commit -m "Add Open in Cursor cask"
   ```

5. **Запушьте и создайте Pull Request:**
   ```bash
   git push origin add-open-in-cursor
   gh pr create --title "Add Open in Cursor" --body "Add Open in Cursor cask - Finder toolbar app to open current folder in Cursor"
   ```

## Требования для Homebrew Cask

- ✅ Приложение должно быть в публичном репозитории
- ✅ Должны быть стабильные релизы с архивами (`.zip`, `.dmg`, и т.д.)
- ✅ SHA256 контрольная сумма (можно использовать `:no_check` для начальной версии, но лучше указать реальную)
- ✅ Минимальная версия macOS (`depends_on macos: ">= :high_sierra"`)

## Проверка Cask

Перед отправкой PR проверьте cask локально:

```bash
brew install --cask --build-from-source /path/to/Casks/open-in-cursor.rb
brew audit --cask --new /path/to/Casks/open-in-cursor.rb
```

## Получение SHA256

Для релиза v1.0.0:

```bash
curl -sL https://github.com/inem/OpenInCursor/releases/download/v1.0.0/Open-in-Cursor.app.zip | shasum -a 256
```

Затем обновите cask файл:
```ruby
sha256 "полученный_hash"
```

## Альтернатива: Использование tap (для тестирования)

Можно создать собственный tap для тестирования:

```bash
# Создайте tap репозиторий на GitHub: homebrew-open-in-cursor
# Затем:
brew tap YOUR_USERNAME/open-in-cursor
brew install open-in-cursor
```

