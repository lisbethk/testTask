Тестовое задание для компании
![testTask](https://user-images.githubusercontent.com/104148937/202721420-e98a614a-aab7-49a0-a48e-716663b39e73.png)
Текст тестового задания: 
"Разработайте экран, где человек может заполнить информацию о себе и своих детях. Сверху должны быть поля ввода ФИО и возраста пользователя.
 
Ниже должна вводится информация о детях. Изначально пользователь видит только кнопку "+", при нажатии на нее появляется блок в котором можно ввести информацию о ребенке: Имя и возраст. Таким образом пользователь может добавить вплоть до 5 детей. Так же напротив каждого ребенка есть кнопка "удалить" , при нажатии на которую соответствующая запись удаляется.
 
Внизу экрана расположена кнопка "Очистить". При нажатии на нее появляется ActionSheet с двумя кнопками "Сбросить данные" и "Отмена". При нажатии на кнопку "Сбросить данные", все данные, введенные на этой странице сбрасываются (в том числе удаляются все дети) и ActionSheet закрывается. При нажатии на кнопку "Отмена" ActionSheet закрывается и сброса данных не происходит.
Интерфейс должен быть разработан на UIKit (не SwiftUI)." 

Желаемый вид интерфейса: 

![task](https://user-images.githubusercontent.com/104148937/202729452-292fb749-d4ef-4ce8-be54-06c25cbdc8d0.png)

1. Используемые фремворки: UIKit, SnapKit.
2. Архитектура MVP(MVP+R)
3. Были использованы: SheetPresentationController, CollectionView, StackView, CollectionReusableView, DiffableDataSource, CompositionalLayout
4. Вёрстка производилась при помощи кода
