# Bätsi

**App de Realidad Aumentada markerless para iPad que hace visible la lengua Hñähñu (Otomí) en el aula, al mismo nivel que el español y el inglés.**

Bätsi permite a niñas y niños de 6 a 9 años colocar etiquetas AR trilingües (Hñähñu – Español – Inglés) sobre objetos reales del salón y escuchar su pronunciación.

> *Not to teach a language. To recognize it.*

<!-- Sugerencia: agrega aquí 2–3 capturas de pantalla o un GIF de la app funcionando.
     Sube las imágenes a una carpeta docs/ y enlázalas así:
     ![Explorador AR](docs/ar-explorer.png) -->

---

## El problema

- Los niños hablantes de Hñähñu son lingüística y culturalmente invisibles en escuelas donde dominan el español y el inglés.
- La lengua indígena no está representada en los objetos cotidianos del entorno escolar.
- Hay una desconexión entre la identidad cultural de los niños otomíes y su entorno de aprendizaje.

## La propuesta

La función de Bätsi **no es enseñar el idioma ni evaluar**, sino **reconocer, dignificar y conectar**, creando un puente simbólico y funcional entre las tres lenguas. Su impacto es simbólico y pedagógico.

### Usuarios

| Tipo | Descripción |
|---|---|
| Primarios | Niños de 6 a 9 años que no hablan Otomí, pero asisten a escuelas cercanas a comunidades hablantes de Hñähñu. |
| Secundarios | Niños hablantes de Otomí, que se benefician al ver su lengua representada y valorada en el aula. |

No requiere materiales impresos ni infraestructura adicional.

---

## Funcionalidades

1. **Onboarding** — Tres páginas deslizables que presentan el problema y la solución.
2. **Bienvenida** — El botón principal muestra *Start / Comenzar* o *Continue Session / Continuar Sesión [N]* según el progreso guardado.
3. **Selección de categoría** — Tres categorías diferenciadas por color, con su nombre en Hñähñu.
4. **Explorador AR** — Cámara a pantalla completa con detección de planos horizontales, lista de objetos y botón *Place / Colocar [PALABRA EN HÑÄHÑU]*.
5. **Etiqueta AR** — Al colocar un objeto aparece:
   - un cubo 3D con 6 texturas únicas del objeto,
   - tres palabras flotantes en 3D: **Hñähñu** (grande, blanco), **Español** (mediano, amarillo) e **Inglés** (pequeño, cian),
   - reproducción automática de la pronunciación en español e inglés (síntesis de voz).

### Vocabulario (9 objetos)

| Categoría | Español | Hñähñu | Inglés |
|---|---|---|---|
| School / *skuela, ngunsadi* | Libro | Mfixụnt'ot'i | Book |
| | Puerta | Gosthi | Door |
| | Mesa | Mexa | Table |
| Games / *nt'eni* | Trompo | Trompo | Trompo |
| | Pelota | Nuni | Ball |
| | Juguete | nt'eni | Toy |
| Food / *hñuni, ntsi* | Chocolate | dẹjụ | Chocolate |
| | Tortilla | Hme | Tortilla |
| | Naranja | nanxa | Orange |

> ⚠️ El vocabulario y la ortografía en Hñähñu aún no han sido validados por un lingüista o hablante nativo (ver [Siguientes pasos](#siguientes-pasos)).

---

## Tecnologías

| | |
|---|---|
| Lenguaje | Swift 6 |
| Proyecto | App de Swift Playgrounds (`Batsi.swiftpm`) |
| Interfaz | SwiftUI |
| Realidad Aumentada | ARKit (detección de planos) + RealityKit (renderizado 3D) |
| Audio | AVFoundation (`AVSpeechSynthesizer`) |
| Persistencia | `@AppStorage` (UserDefaults) |
| Texturas de los cubos | Generadas con IA generativa (Grok) |

---

## Cómo ejecutarla

**Requisitos**
- iPad con cámara (la app necesita ARKit, así que no funciona en el simulador).
- iPadOS 16.0 o superior.
- Swift Playgrounds en iPad, o Xcode en Mac.

**Pasos**
1. Clona o descarga este repositorio.
2. Abre la carpeta `Batsi.swiftpm` con Swift Playgrounds o con Xcode.
3. Ejecuta la app en un iPad físico y acepta el permiso de cámara.
4. Apunta la cámara a una superficie horizontal, elige una categoría y un objeto, y toca **Place / Colocar**.

---

## Estructura del proyecto

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
├── Media.xcassets/             # Texturas de los cubos y colores
└── Package.swift
```

### Flujo de datos

1. `MyApp` carga `ContentView`, que muestra `OnboardingView` o `WelcomeView` según `hasFinishedIntro`.
2. Al terminar el onboarding, un *binding* cambia `hasFinishedOnboarding = true` y se pasa a `WelcomeView`.
3. `WelcomeView` lee `currentSession` desde `@AppStorage`; si es 0 lo cambia a 1 y navega a `CategorySelectionView`.
4. `CategorySelectionView` recorre `Category.allCases` y, con `NavigationLink`, abre `ARExplorerView` con la categoría elegida.
5. `ARExplorerView` filtra `allObjects` por categoría y mantiene `selectedObject` y `placeTrigger`.
6. Estos estados se pasan como `@Binding` a `ARViewContainer`. Cuando `shouldPlace` es `true`, limpia la escena anterior y llama a `ARLabelManager.createObject(for:color:)`.
7. `ARLabelManager` construye el cubo con 6 planos texturizados y apila encima los 3 textos 3D.
8. `AVSpeechSynthesizer` pronuncia la palabra en español y en inglés, con un retraso de 1.8 s.
9. El conjunto se ancla con `AnchorEntity(world: [0, 0, -0.5])`, a 50 cm frente a la cámara.

---

## Estado del proyecto

**Avance aproximado: 70 %.** La app funciona de principio a fin (onboarding → bienvenida → selección → AR → colocación con audio).

- [x] Onboarding de 3 páginas con transiciones animadas
- [x] Bienvenida con detección de primera sesión vs. continuación
- [x] Persistencia de la sesión con `@AppStorage`
- [x] 3 categorías con sistema de colores
- [x] ARKit + RealityKit con detección de planos horizontales
- [x] Cubos 3D con 6 texturas únicas por objeto
- [x] Texto 3D trilingüe con jerarquía visual
- [x] Pronunciación automática en español e inglés
- [x] 9 objetos con vocabulario trilingüe
- [x] Diseño visual con patrones folk otomíes

## Siguientes pasos

- [ ] **Desbloqueo por sesión:** 1 objeto por categoría en la sesión 1, 2 en la sesión 2 y acceso total en la sesión 3.
- [ ] **Recompensas:** +10 puntos por objeto colocado, animaciones de éxito, estrellas y stickers culturales otomíes.
- [ ] **Pantalla "¡Misión Completada!":** cierre de sesión que incrementa `currentSession` y entrega estrella y sticker.
- [ ] **Audio en Hñähñu con hablantes nativos:** reemplazar la síntesis de voz por grabaciones reales de la comunidad otomí.
- [ ] **Mejor anclaje AR:** usar *raycast* sobre los planos detectados en lugar de la posición fija, para colocar el objeto sobre superficies reales.
- [ ] **Ícono propio de Bätsi** (hoy es el ícono genérico de lápiz).
- [ ] **Validación lingüística** del vocabulario con un lingüista o hablante nativo.
- [ ] **Pruebas con usuarios** de 6 a 9 años en una escuela cercana a una comunidad otomí.

---

## Autora

**Myrahis Yurizahan Sanluis Cerezo** — Desarrolladora principal
Universidad de las Américas Puebla (UDLAP) · myrahis.sanluisco@udlap.mx
