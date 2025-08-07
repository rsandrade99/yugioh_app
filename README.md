# 📦 `CardItem` Widget - Flutter

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
│       └── card_entity.dart         # Modelo de datos de la tarjeta
├── presentation/
│   └── ui/
│       ├── atoms/
│       │   └── wid_text.dart        # Widget de texto estilizado (CustomText)
│       ├── molecules/
│       │   └── wid_card_imagen.dart # Widget de imagen con decoración
│       └── organisms/
│           └── card_item.dart       # ESTE widget
```

## 🧪 Uso

```dart
CardItem(
  card: CardEntity(
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
- Widgets personalizados: `CardImage`, `CustomText`

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

**Robert**  
Ingeniero en Tecnologías de Información  