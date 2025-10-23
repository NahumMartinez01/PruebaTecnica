🎬 AvengersApp – Prueba Técnica iOS 

📱 Descripción
AvengersApp es una aplicación desarrollada en SwiftUI que consume la API pública de The Movie Database (TMDB)
Permite explorar una lista de películas, consultar sus detalles y agregar favoritos utilizando persistencia local con Core Data.
El proyecto fue construido siguiendo buenas prácticas de arquitectura (MVVM), aprovechando async/await para manejo de concurrencia moderna, y cuenta con pruebas unitarias y de interfaz (Unit y UI Tests).

🧩 Características principales
Listado de peliculas obtenidas desde la API pública de The Movie Database (TMDB) mostrando inicialmente solo peliculas de Avengers
Pantalla de detalles que contiene poster, titulo, calificación,fecha estreno,sinopsis,botón para añadir a favoritos
Buscador de peliculas nos permite buscar cualquier pelicula que se encuentre en el API de TMDBS
Peliculas favoritas con persistencia de datos con **Core Data**
Diseño moderno con SwiftUI
Arquitectura MVVM, separando Lógica de negocio, Vistas y Modelos
Uso de Async/ Await para peticiones asíncronas limpias.
Pruebas Unitarias (XCTest)
Pruebas UI (XCUITest)

⚙️ Tecnologías utilizadas
| Tecnología                        | Descripción                        |
| --------------------------------- | ---------------------------------- |
| **Swift 6.1.2**                   | Lenguaje principal                 |
| **SwiftUI**                       | Framework de interfaz declarativa  |
| **MVVM**                          | Patrón de arquitectura             |
| **Core Data**                     | Persistencia de favoritos          |
| **Async/Await**                   | Concurrencia moderna               |
| **XCTest / XCUITest**             | Testing unitario y de interfaz     |
| **The Movie Database API (TMDB)** | Fuente de datos                    |

🏗️ Arquitectura (MVVM)
El proyecto está organizado bajo el patrón Model-View-ViewModel para promover modularidad, escalabilidad y testabilidad.
── AvengersApp
│   ├── App
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   ├── Colors
│   │   │   │   ├── Contents.json
│   │   │   │   ├── background.colorset
│   │   │   │   ├── borderCard.colorset
│   │   │   │   └── toastBg.colorset
│   │   │   └── Contents.json
│   │   ├── Persistence.swift
│   │   ├── en.lproj
│   │   │   └── Localizable.strings
│   │   └── es-419.lproj
│   │       └── Localizable.strings
│   ├── Models
│   │   └── MoviesResponse.swift
│   ├── Network
│   │   ├── APIConstants.swift
│   │   └── NetworkManager.swift
│   ├── Persistence
│   │   ├── AvengersApp.xcdatamodeld
│   │   │   └── AvengersApp.xcdatamodel
│   │   │       └── contents
│   │   └── AvengersAppApp.swift
│   ├── Test
│   │   ├── AvengersAppTests
│   │   │   └── FavoriteViewModelTests.swift
│   │   └── AvengersUIAppTests
│   │       ├── AvengersAppUITests.swift
│   │       └── AvengersUIAppTestsLaunchTests.swift
│   ├── Utils
│   │   ├── AppUtils.swift
│   │   ├── Enums.swift
│   │   └── MyAppManager.swift
│   ├── View
│   │   ├── Components
│   │   │   ├── CardItemsView.swift
│   │   │   ├── DescriptionView.swift
│   │   │   ├── EmptyDataView.swift
│   │   │   ├── GeneralMovieInformationView.swift
│   │   │   ├── PosterView.swift
│   │   │   ├── SearchBarView.swift
│   │   │   ├── ToastMessage.swift
│   │   │   └── VoteProgressCircle.swift
│   │   ├── ContentView.swift
│   │   ├── DetailView.swift
│   │   ├── FavoritesView.swift
│   │   └── HomeView.swift
    └── ViewModel
        ├── FavoriteViewModel.swift
        └── MovieViewModel.swift 

🔑 Configuración del proyecto
```bash 
