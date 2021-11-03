
1. Добавьте sdk через pod

```
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'MovikaSDK'
end
```

Замените YOUR_TARGET_NAME и перейдите в папку Podfile и выполните команду:

````
$ pod install
````

2. Добавьте ваш ApiKey 

В классе AppDelegate в методе application didFinishLaunchingWithOptions

Импортируйте фреймворк 
````
import MovikaSDK
````

Добавьте Movika.shared.apiKey = API_KEY
````
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Movika.shared.apiKey = API_KEY
        return true
    }
````

### Настройте плеер
1. Создайте новый класс view controller и унаследйте его от класса MovikaPlayerViewController
2. Загрузите данные (стуктура GameManifest) необходимые для воспроизведения фильма, используя DefaultGameManifestDownloader метод load
3. Когда GameManifest будет загружен передайте его плееру вызвав метод класса контроллера setup
4. Для отслеживания состояния интерактивного фильма, установите значение  movieStateDelegate  для UIViewController плеера     

````
 self.setup(manifest: manifest,
            customEventViewFactory: nil,
            config: PlayerConfiguration.defaultConfig)
````


### Настройте внешний вид элементов управления воспроизведением 
Если необходимо настроить внешний вид меню паузы и кнопки остановки воспроизведения, переопределите методы класса контроллера 
- providePauseMenu 
- providePauseButton

Данные методы вернут UIView элементы которые будут использоваться вместо элементов по умолчанию.

Если необходимо настроить цвета элементов управления интерактивом, то переопределите переменную UIManager в MovikaPlayerViewController с заданной темой. 

### Сохранение фильма
В процессе воспроизведения фильма происходит автоматическое сохранение состояния фильма в текущий момент. Такого рода сохранения происходят перед наступлением событий меняющих сюжет фильма (пользователю предоставляется кнопочный выбор варианта сюжета).

Если пользователь вышел из фильма не досмотрев его, вы можете предоставить ему возможность продолжить воспроизведения с точки сохранения. Для этого при вызове метода self.setup в параметре startFromSavePoint поредейте true

Наличие точек сохранения можно проверить используя класс PlayerRepository:

````
PlayerRepository.isMoveSaved(movieId: String)
````

### Создание пользовательских интерактивов
1. Создается представление(интерактив), как правило наследуемое от UIView
2. Класс интерактива реализует протокол CustomEventViewProtocol 
3. В конструктор интерактива передается структура InteractiveEvent содержащая основную информацию по интерактиву (время начала, время завершения, список доступных вариантов развития сюжета, тип и т.д.)
4. В конструктор интерактива передается класс CustomEventResultDelegate позволяющий передать результат взаимодействия пользователя с интерактивом
5. Вызвав метод  resultSelected(index: Int) интерактив передаст результат, после чего мгновенно будет удален со сцены 
6. Если вам необходимо сначала передать результат после чего отобразить какую-то анимацию используйте методы resultSelected(index: Int, instantlyDetach: true), после завершения анимации метод detachFromParent()
7. Для создания кастомных интерактивов необходимо при создании контроллера плеера передать фабрику создающую по customType определенный интерактив 
8. Фабрика интерактивов должны реализовать протокол CustomEventViewFactory


[Пример подключения sdk](https://bitbucket.org/interactiveplatform/ios.sdk.sample.interactive.film/src/)


