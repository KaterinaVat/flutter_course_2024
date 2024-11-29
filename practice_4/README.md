# Notes App

## Описание
Приложение позволяет пользователю создавать, просматривать, редактировать и удалять заметки. Управление состоянием реализовано с использованием **Provider**.

## Использованные виджеты
- `TextField` для ввода названия и текста заметки
- `ListView.builder` для отображения списка заметок
- `SnackBar` для уведомлений об удалении
- `ListTile` для отображения заметок в списке
- `FloatingActionButton` для добавления новых заметок
- `ElevatedButton` для кнопки удаления заметки

## Видео-демо

[Notes App Demo](demo/demo.webm)

## Установка и запуск

1. Клонируйте репозиторий на свой компьютер.
2. Откройте проект в IDE, поддерживающей Flutter (например, Android Studio или Visual Studio Code).
3. Убедитесь, что Flutter установлен и настроен правильно.
4. Запустите приложение на эмуляторе или физическом устройстве с помощью команды `flutter run`.

## Использование

- Для просмотра списка заметок откройте главный экран.
- Нажмите на заметку, чтобы открыть ее для редактирования или просмотра.
- Используйте кнопку "+" для создания новой заметки.
- В редакторе заметки можно вводить и редактировать название и текст заметки.
- Для удаления заметки нажмите кнопку "Удалить" в редакторе заметки.