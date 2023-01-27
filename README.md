# Recipes-iOS

## Installation
Run git clone to download proyect

```ruby
git clone https://github.com/luisMan97/Recipes-iOS.git
```

#### Third Party Libraries
The project does not use third party libraries. Don't cocoapods, don't cartage, don't worry :)

#### Funcionalidades
- La pantalla principal cuenta con dos principales secciones; las recetas de la API publica de spoonacular ((https://spoonacular.com/food-api)) y los favoritos persisitos localmente (Favorites).
- La pantalla principal, sección de "Recetas" tiene un botón para volver a llamar las recetas desde el API.
- La pantalla principal, tanto la sección de "Recetas" cómo de "Favoritos" cuentan con una barra de busqueda, la sección de "Recetas" busca en el API y la sección de "Favoritos" busca localmente.
- Las filas de los recetas de la pantalla principal tienen un indicador (estrella) cuando está guardado como favorito.
- Cuando se selecciona una receta se va al detalle de la receta.
- La pantalla principal, sección de "Favoritos" tiene un botón para editar las recetas favoritas, más especificamente poderlos eliminar.
- Cada receta de los favoritos tiene el gesto nativo de deslizar y eliminar.
- En la pantalla del detalle de la receta se visualiza la descripción y la imágen de la receta.
- En la pantalla del detalle de la receta se tiene un botón para guardar en favoritos la receta.

- Se muestra mensaje de error cuando el servicio falla o no hay conexión a internet.
- Hay una modal de loading que se muestra cada vez que se hace la petición al servicio web.

#### Funcionalidades técnicas:
- La aplicación está desarrollada en Swift 5, con SwiftUI, Combine y Async/Await.
- La aplicación tiene cómo arquitectura un tipo de MVVM extendido (CLEAN Architecture).
- La aplicación usa programación reactiva con Combine.
- La aplicación implementa diferentes patrones de diseño (Repository, Factory entre otros).
- La aplicación hace uso de inyección de dependencias.
- La aplicación hace uso de los principios SOLID.
- La aplicación no usa librerías de terceros.
- La aplicación contiene test unitarios de las casos de uso y viewmodels.
- La aplicación usa una capa genérica y extensible con URLSession para hacer los llamados a los servicios.  
- La aplicación usa Codable para el mapeo de JSON a objetos. 
- La aplicación contiene un .gitignore para no subir archivos innecesarios.

#### Arquitectura
Se implementó CLEAN como arquitectura, con las siguientes capas:
1) View: Contiene las View de SwiftUI
2) Presentation: Contiene los ViewModels
3) Interactor/UseCases: Contiene los casos de uso (acciones de la aplicación y lógica de negocios)
4) Entity/Domain: Contiene las entidades
5) Data: Contiene el patrón repository para obtener los datos ya sea de una API o una base de datos local
6) Framework: Contiene la implementación a más detalle de la obtención de datos usando ya la respectiva librería o framework (URLSession, CoreData y etc)
