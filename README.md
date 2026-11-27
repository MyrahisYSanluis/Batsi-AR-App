# Bätsi

**Español** · [English](README.en.md)

**App de Realidad Aumentada markerless para iPad que hace visible la lengua Hñähñu (Otomí) en el aula, al mismo nivel que el español y el inglés.**

Bätsi permite a niñas y niños de 6 a 9 años colocar etiquetas AR trilingües (Hñähñu – Español – Inglés) sobre objetos reales del salón y escuchar su pronunciación.

> *Not to teach a language. To recognize it.*

<!-- Sugerencia: agrega aquí 2–3 capturas de pantalla o un GIF de la app funcionando.
     Sube las imágenes a una carpeta docs/ y enlázalas así:
     ![Explorador AR](docs/ar-explorer.png) -->

## Contenido

1. [Información general](#1-información-general)
2. [Descripción](#2-descripción)
3. [Usuarios](#3-usuarios)
4. [Herramientas y tecnologías](#4-herramientas-y-tecnologías)
5. [Cómo ejecutarla](#5-cómo-ejecutarla)
6. [Pantallas y funcionalidades](#6-pantallas-y-funcionalidades)
7. [Flujo de datos](#7-flujo-de-datos)
8. [Estructura del repositorio](#8-estructura-del-repositorio)
9. [Avance del proyecto](#9-avance-del-proyecto)
10. [Siguientes pasos](#10-siguientes-pasos)
11. [Autora](#11-autora)

---

## 1. Información general

| | |
|---|---|
| Nombre | Bätsi |
| Tipo | App de Realidad Aumentada para iPad |
| Fecha de inicio | 13 de enero de 2026 |
| Fecha de entrega estimada | 28 de febrero de 2026 |
| Avance | ≈ 70 % |
| Institución | Universidad de las Américas Puebla (UDLAP) |

---

## 2. Descripción

Bätsi es una aplicación de Realidad Aumentada *markerless* desarrollada en SwiftUI para iPad que busca hacer visible la lengua Hñähñu (Otomí) en el espacio escolar, al mismo nivel que el español y el inglés. Los niños colocan etiquetas AR trilingües (Hñähñu–Español–Inglés) sobre objetos reales del aula y escuchan su pronunciación.

### Problemas que resuelve

- La invisibilidad lingüística y cultural de los niños hablantes de Hñähñu en entornos escolares dominados por el español y el inglés.
- La falta de representación de la lengua indígena en los objetos cotidianos del entorno escolar.
- La desconexión entre la identidad cultural de los niños otomíes y su entorno de aprendizaje.

### Enfoque

La función de la app **no es enseñar el idioma ni evaluar**, sino **reconocer, dignificar y conectar**, creando un puente simbólico y funcional entre las tres lenguas. Su impacto es simbólico y pedagógico, no sistémico.

---

## 3. Usuarios

| Tipo | Descripción |
|---|---|
| Primarios | Niños de 6 a 9 años que no hablan Otomí, pero asisten a escuelas cercanas a comunidades hablantes de Hñähñu. |
| Secundarios | Niños hablantes de Otomí, que se benefician al ver su lengua representada y valorada en el aula. |

### Necesidades principales

- Reconocer y respetar la lengua Hñähñu como igual al español y al inglés.
- Aprender vocabulario básico de forma interactiva y exploratoria mediante AR.
- Conectar el aprendizaje lingüístico con objetos reales del entorno físico.
- Sentirse representados culturalmente (usuarios secundarios).
- Una experiencia accesible, sin materiales impresos ni infraestructura adicional.

---

## 4. Herramientas y tecnologías

| | |
|---|---|
| Lenguaje | Swift 6 |
| Proyecto | App de Swift Playgrounds (`Batsi.swiftpm`) |
| Interfaz | SwiftUI |
| Realidad Aumentada | ARKit (detección de planos) + RealityKit (renderizado 3D) |
| Audio | AVFoundation (`AVSpeechSynthesizer`) |
| Utilidades | UIKit y Foundation |
| Persistencia | `@AppStorage` (UserDefaults) |
| Texturas de los cubos | IA generativa (Grok) para las imágenes de cada objeto: puerta, libro, mesa, pelota, trompo, juguete, chocolate, tortilla y naranja |

---

## 5. Cómo ejecutarla

**Requisitos**
- iPad con cámara (la app usa ARKit, así que no funciona en el simulador).
- iPadOS 16.0 o superior.
- Swift Playgrounds en iPad, o Xcode en Mac.

**Pasos**
1. Clona o descarga este repositorio.
2. Abre la carpeta `Batsi.swiftpm` con Swift Playgrounds o con Xcode.
3. Ejecuta la app en un iPad físico y acepta el permiso de cámara.
4. Apunta la cámara a una superficie horizontal, elige una categoría y un objeto, y toca **Place / Colocar**.

---

## 6. Pantallas y funcionalidades

### 6.1 Onboarding (`OnboardingView`)
Tres páginas deslizables que presentan el problema y la solución:
- **Página 1:** *"Languages exist. But not all are seen."* — Estadística de UNESCO sobre niños indígenas.
- **Página 2:** *"When a language is invisible, children feel invisible."* — Contexto del problema en escuelas otomíes.
- **Página 3:** *"Meet Bätsi."* — Presentación de la solución con el botón **Start Exploring**.

### 6.2 Bienvenida (`WelcomeView`)
Logo de Bätsi (ave naranja), título y botón principal que muestra *Start / Comenzar* o *Continue Session / Continuar Sesión [N]* según el progreso guardado.

### 6.3 Selección de categoría (`CategorySelectionView`)
Tres categorías diferenciadas por color, con su traducción al Hñähñu:

| Categoría | Color |
|---|---|
| School / *skuela, ngunsadi* | Teal |
| Games / *nt'eni* | Verde |
| Food / *hñuni, ntsi* | Coral |

### 6.4 Explorador AR (`ARExplorerView`)
- Cámara a pantalla completa con detección de planos horizontales.
- Encabezado con botón de regreso y etiqueta de la categoría actual.
- Lista horizontal de objetos seleccionables (íconos SF Symbols).
- Botón principal *Place / Colocar [PALABRA EN HÑÄHÑU]* en el color de la categoría.

### 6.5 Etiqueta AR colocada
Al presionar **Place** aparece en el espacio real:
- Un cubo 3D con 6 texturas únicas del objeto (generadas con IA).
- Tres palabras flotantes en 3D apiladas con jerarquía visual:
  - **Hñähñu** — la más grande, en blanco
  - **Español** — mediana, en amarillo
  - **Inglés** — pequeña, en cian
- Reproducción automática del nombre en español e inglés con síntesis de voz.

### 6.6 Vocabulario (9 objetos)

| Categoría | Español | Hñähñu | Inglés |
|---|---|---|---|
| School | Libro | Mfixụnt'ot'i | Book |
| | Puerta | Gosthi | Door |
| | Mesa | Mexa | Table |
| Games | Trompo | Trompo | Trompo |
| | Pelota | Nuni | Ball |
| | Juguete | nt'eni | Toy |
| Food | Chocolate | dẹjụ | Chocolate |
| | Tortilla | Hme | Tortilla |
| | Naranja | nanxa | Orange |

> ⚠️ El vocabulario y la ortografía en Hñähñu aún no han sido validados por un lingüista o hablante nativo (ver [Siguientes pasos](#10-siguientes-pasos)).

---

## 7. Flujo de datos

### 7.1 Modelo de datos (`LearnObject`)
Cada objeto educativo es una estructura `Identifiable` con:

| Campo | Descripción |
|---|---|
| `id` | `UUID` |
| `category` | `enum Category`: `school`, `games`, `food` |
| `spanish`, `hnahnu`, `english` | La palabra en cada idioma |
| `audioFileName` | Nombre del archivo de audio |
| `model3DName` | Referencia a las texturas en `Media.xcassets` |
| `imageName` | SF Symbol del ícono |

### 7.2 Datos persistentes del usuario
- `currentSession: Int` — guardado con `@AppStorage` en UserDefaults; persiste entre sesiones de la app.

### 7.3 Flujo en tiempo de ejecución
1. **Arranque:** `MyApp` carga `ContentView`, que muestra `OnboardingView` o `WelcomeView` según `hasFinishedIntro`.
2. **Onboarding:** el usuario recorre las 3 páginas con un `TabView`. Al terminar, se activa `hasFinishedOnboarding = true` mediante *binding* y se pasa a `WelcomeView`.
3. **Bienvenida:** `WelcomeView` lee `currentSession` desde `@AppStorage`. Si es 0, lo cambia a 1 al tocar el botón y navega a `CategorySelectionView` con `NavigationStack`.
4. **Selección:** `CategorySelectionView` recorre `Category.allCases` y, al elegir una, abre `ARExplorerView` con `NavigationLink`, pasando la categoría.
5. **Exploración AR:** `ARExplorerView` filtra `allObjects` por categoría y mantiene dos `@State`: `selectedObject` (objeto activo) y `placeTrigger` (señal de colocación).
6. **Colocación AR:** esos estados se pasan como `@Binding` a `ARViewContainer` (un `UIViewRepresentable` que envuelve el `ARView` de RealityKit). Cuando `shouldPlace` es `true`, se limpia la escena anterior y se llama a `ARLabelManager.createObject(for:color:)`.
7. **Modelo 3D:** `ARLabelManager` construye el cubo entidad por entidad: 6 planos texturizados (uno por cara) posicionados en 3D. Encima apila 3 entidades de texto 3D (Hñähñu, español, inglés).
8. **Audio:** después de colocar el objeto, `reproducirSecuenciaDeAudio` usa `AVSpeechSynthesizer` para pronunciar el nombre en español y en inglés, con un retraso de 1.8 s.
9. **Anclaje:** el conjunto se ancla con `AnchorEntity(world: [0, 0, -0.5])`, a 50 cm frente a la cámara.

---

## 8. Estructura del repositorio

```
Batsi.swiftpm/
├── MyApp.swift                 # Punto de entrada
├── ContentView.swift           # Decide entre Onboarding y Bienvenida
├── OnboardingView.swift        # 3 páginas de introducción
├── WelcomeView.swift           # Pantalla de bienvenida y sesión actual
├── CategorySelectionView.swift # Selección de categoría
├── ARExplorerView.swift        # Vista principal de AR
├── ARViewContainer.swift       # Puente SwiftUI ↔ ARView (RealityKit)
├── ARLabelManager.swift        # Construye el cubo 3D, el texto y el audio
├── LearnObject.swift           # Modelo de datos y vocabulario
├── FolkScreenWrapper.swift     # Fondo con patrones folk otomíes
├── Theme.swift                 # Paleta de colores
├── Media.xcassets/             # Texturas de los cubos (6 por objeto) y colores
└── Package.swift
```

---

## 9. Avance del proyecto

**Avance aproximado: 70 %.** La app funciona de principio a fin (onboarding → bienvenida → selección → AR → colocación con audio). Hay espacio importante de mejora en gamificación, autenticidad lingüística y precisión del anclaje AR.

### Funcionalidades implementadas
- [x] Onboarding de 3 páginas con transiciones animadas
- [x] Pantalla de bienvenida con detección de primera sesión vs. continuación
- [x] Persistencia del progreso con `@AppStorage`
- [x] Selección de 3 categorías con sistema de colores diferenciado
- [x] ARKit + RealityKit con detección de planos horizontales
- [x] Cubos 3D con 6 caras texturizadas únicas por objeto (texturas generadas con IA)
- [x] Texto 3D en 3 idiomas con jerarquía visual (tamaños y colores)
- [x] Pronunciación automática en español e inglés con síntesis de voz
- [x] 9 objetos con vocabulario trilingüe (3 por categoría)
- [x] Diseño visual con patrones folk otomíes (`FolkScreenWrapper`)
- [x] Sistema de colores temático (`Theme.swift`)

### Bloqueos o problemas
No hay bloqueos críticos. El flujo principal funciona correctamente; lo pendiente son mejoras que escalarán la experiencia, no impedimentos para su funcionamiento actual.

---

## 10. Siguientes pasos

- [ ] **Desbloqueo por sesión:** filtrar los objetos según `currentSession` (1 objeto por categoría en la sesión 1, 2 en la sesión 2 y acceso total en la sesión 3), como en el diseño original.
- [ ] **Sistema de recompensas:** +10 puntos por objeto colocado, animaciones de éxito, estrellas y stickers culturales otomíes coleccionables.
- [ ] **Pantalla "¡Misión Completada!":** cierre de sesión que incrementa `currentSession` automáticamente y entrega una estrella, un sticker y un mensaje positivo.
- [ ] **Audio en Hñähñu con hablantes nativos:** reemplazar la síntesis de voz por grabaciones reales de miembros de la comunidad otomí, para asegurar autenticidad y pronunciación correcta.
- [ ] **Mejor anclaje AR:** sustituir la posición fija `[0, 0, -0.5]` por *raycast* sobre los planos detectados, para que el niño coloque el objeto sobre superficies reales del aula.
- [ ] **Ícono propio de Bätsi** (hoy es el ícono genérico de lápiz).
- [ ] **Validación lingüística:** revisar vocabulario y ortografía del Hñähñu con un lingüista o hablante nativo.
- [ ] **Pruebas con usuarios reales:** sesiones con niños de 6 a 9 años en una escuela cercana a una comunidad otomí, para recopilar retroalimentación y ajustar la experiencia.

---

## 11. Autora

| Nombre | Rol |
|---|---|
| [Myrahis Sanluis Cerezo](https://github.com/MyrahisYSanluis) | Desarrolladora principal |

Universidad de las Américas Puebla (UDLAP)
