# Параллельное вычисление

> данная страничка является скорее ознакомительной для ликбеза в терминологии

> текст здесь частично нагло сворован

Есть несколько разных понятий, связанных с областью параллельных вычислений:

- Конкурентное исполнение ([concurrency](https://en.wikipedia.org/wiki/Concurrent_computing))
- Параллельное исполнение ([parallel execution](https://en.wikipedia.org/wiki/Parallel_computing))
- Многопоточное исполнение ([multithreading](https://en.wikipedia.org/wiki/Multithreading_(computer_architecture)))
- Асинхронное исполнение ([asynchrony](https://en.wikipedia.org/wiki/Asynchrony_(computer_programming)))

Каждый из этих терминов строго определен и имеет четкое значение.

## Конкурентность (concurrency)

Конкурентность - это наиболее общий термин, который говорит, что одновременно выполняется более одной задачи. Например, вы можете одновременно варить помешивать пельмени чтобы не слиплись и листать тиктоки. Винда, даже 95-я могла одновременно играть музыку и показывать фотки.

Конкурентное исполнение - это самый общий термин, который не говорит о том, каким образом эта конкурентность будет получена: путем приостановки некоторых вычислительных элементов и их переключение на другую задачу, путем действительно одновременного исполнения, путем делегации работы другим устройствам или еще как-то. Это не важно.

Конкурентное исполнение говорит о том, что за определенный промежуток времени будет решена более, чем одна задача. Точка.

## Параллельное исполнение

Параллельное исполнение подразумевает наличие более одного вычислительного устройства (например, процессора), которые будут одновременно выполнять несколько задач.

Параллельное исполнение - это строгое подмножество конкурентного исполнения. Это значит, что на компьютере с одним процессором параллельное программирование - невозможно. 

> Здесь под процессором понмиается настоящее физическое ядро в процессоре, а не логическое ядро, которое может быть создано с помощью операционной системы. Так же не обладаю информацией относятся ли сюда гипертрединг ядра когда процессор 2 ядра 4 потока.

## Многопоточность

Многопоточность - это один из способов реализации конкурентного исполнения путем выделения абстракции "рабочего потока" (worker thread).

Потоки "абстрагируют" от пользователя низкоуровневые детали и позволяют выполнять более чем одну работу "параллельно". Операционная система, среда исполнения или библиотека прячет подробности того, будет многопоточное исполнение конкурентным (когда потоков больше чем физических процессоров), или параллельным (когда число потоков меньше или равно числу процессоров и несколько задач физически выполняются одновременно).

## Асинхронное исполнение

Асинхронность (asynchrony) подразумевает, что операция может быть выполнена кем-то на стороне: удаленным веб-узлом, сервером или другим устройством за пределами текущего вычислительного устройства.

Основное свойство таких операций в том, что начало такой операции требует значительно меньшего времени, чем основная работа. Что позволяет выполнять множество асинхронных операций одновременно даже на устройстве с небольшим числом вычислительных устройств.

## CPU-bound и IO-Bound операции

Еще один важный момент, с точки зрения разработчика - разница между CPU-bound и IO-bound операциями. CPU-Bound операции нагружают вычислительные мощности текущего устройства([например транскодирование видео как в ютубе, когда загружаешь в него видео full hd, а на выходе вариации от 144p до исходного](https://en.wikipedia.org/wiki/Transcoding)), а IO-Bound означает что в основном мы ожидаем ввод или вывод(например пока скрипт ожидает выполнения sql запроса во внешней СУБД как PostgreSQL, мы можем обработать другой запрос и его тоже асинхронно пустить выполняться в СУБД).

Разница важна тем, что число одновременных операций зависит от того, к какой категории они относятся. Вполне нормально запустить параллельно сотни IO-Bound операций, и надеяться, что хватит ресурсов обработать все результаты. Запускать же параллельно слишком большое число CPU-bound операций (больше, чем число вычислительных устройств) бессмысленно.
