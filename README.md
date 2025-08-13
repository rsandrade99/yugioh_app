# YugiohApp

# 📦 `CartaItem` Widget - Flutter

Componente personalizado y reutilizable en Flutter para mostrar tarjetas visualmente atractivas con imagen, título, subtítulo y descripción con desplazamiento suave. Ideal para catálogos, e-commerce, apps de contenido o listas interactivas.

## ✨ Características

- Diseño moderno con sombra, bordes redondeados y efectos visuales suaves.
- Layout responsive utilizando `ResponsiveFramework`.
- Scroll interno elegante para descripciones largas.
- Completamente personalizable y reutilizable.
- Separación limpia de responsabilidades (estructura tipo MVC).

## 🧱 Estructura

```
lib/
├── domain/
│   └── entities/
│       └── carta_entity.dart         # Modelo de datos de la tarjeta
├── presentation/
│   └── widgets/
│       ├── atoms/
│       │   └── wid_text.dart        # Widget de texto estilizado (CustomText)
│       ├── molecules/
│       │   └── wid_carta_imagen.dart # Widget de imagen con decoración
│       └── organisms/
│           └── carta_item.dart       # ESTE widget
```

## 🧪 Uso

```dart
CardItem(
  card: CartaEntity(
    name: 'Nombre del producto',
    type: 'Categoría',
    description: 'Descripción larga del producto...',
    imageUrl: 'https://link-a-la-imagen.jpg',
  ),
  onTap: () {
    // Acción al tocar la tarjeta
  },
),
```

## 📐 Dependencias

- `flutter`
- `responsive_framework`
- Widgets personalizados: `CartaImage`, `CustomText`

## 🔮 Preview (Mockup visual imaginario)

```
+--------------------------------------------------+
|  [Imagen con sombra]  |  Nombre del ítem        |
|                       |  Tipo de ítem (italic)  |
|                       |  ---------------------  |
|                       |  Descripción scrollable |
+--------------------------------------------------+
```

## 🧠 Buenas prácticas aplicadas

- Utilización de `InkWell` para feedback táctil.
- Composición de widgets pequeños para escalabilidad.
- Responsive desde diseño.
- Código limpio y legible.

## 🧑‍💻 Autor

**Robert Andrade**  
Ingeniero en Tecnologías de Información  
Desarrollador Flutter especializado en arquitectura escalable, diseño profesional y experiencia de usuario.
- [GitHub](https://github.com/rsandrade99) 
- [LinkedIn](https://www.linkedin.com/in/rsandradea99/) 
- rsandradea@gmail.com
- [Instagram](https://www.instagram.com/robert_0899/)
