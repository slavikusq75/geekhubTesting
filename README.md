# geekhubTesting
## Проект тестування Geekhub

### Вимоги до додатку Тестування студентів GeekHub
- Студент повинин мати змогу обрати кілька курсів;
- Тести мають складатися з питань, відповівши на які, студент отримує бали;
- Питання можуть містити варіанти відповідей;
- Питання може бути двох типів: 
  - одне правильне (radio list);
  - одне або клька правильних (check list).

### Ролі користувачів системи
- User
  - може Реєструватись в системі (коли користувач реєструється йому надається роль User);
  - може логінитись до системи;
  - може передивлятися перелік курсів;
  - може проходити тести;
  - може переглядати історію пройдених тестів;
- Course admin (teacher)
  - може логінитись до системи;
  - може виконувати CRUD тестів для свого курсу;
  - може виконувати CRUD тем питань;
  - може виконувати CRUD питань;
  - може виконувати CRUD відповідей;
- Super admin
  - може логінитись до системи;
  - може виконувати CRUD курсів;
  - може виконувати CRUD тестів;
  - може управляти ролями користувачів (Grant/Revoke);
Кожна верхня роль наслідує попередню.

### Особливості Структури БД
- Структура БД умовно розділена на дві частини:
  - тести;
  - історія тестів що здавав студент.
- Таблиці, призначені для зберігання інформації про пройдені тести зберігають ID та текстову інформацію записів у відповідних таблицях. Це потрібно на випадок, якщо данні будуть відредаговані, щоб історія збереглася.
- Питання та відповіді поділяються за темами;
- Відповіді зберігаються незалежно від питань. Так зроблено щоб при формуванні тесту їх можна було обирати з уже існуючого набору. Це надасть можливість зменшити їх загальну кількість і не буде необхідності створювати неправельні варіанти відповідей, адже їх можна буде вибирати з різних тем.
