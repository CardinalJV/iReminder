<a href="https://developer.apple.com/xcode/swiftui/"> 
  <img src="https://raw.githubusercontent.com/CardinalJV/CardinalJV/main/assets/logo-swift/swiftui-96x96_2x.png" alt="SwiftUI" title="SwiftUI" width="75" height="75"/></a>
<a href="https://developer.apple.com/xcode/swiftdata/">
  <img src="https://raw.githubusercontent.com/CardinalJV/CardinalJV/main/assets/logo-swift/swiftdata-96x96_2x.png" alt="SwiftData" title="SwiftData" width="75" height="75"/></a>
<a href="https://developer.apple.com/widgets/">
  <img src="https://raw.githubusercontent.com/CardinalJV/CardinalJV/main/assets/logo-swift/widgetkit-96x96_2x.png" alt="WidgetKit" title="WidgetKit" width="75" height="75"/></a>

# iReminder 

iReminder est une application de gestion de rappels qui permet aux utilisateurs de créer, suivre et compléter leurs tâches. L'application utilise SwiftData pour la gestion des rappels en locales(Création, modification et suppression).

## ScreenCast

https://github.com/user-attachments/assets/2fe9ba55-65ba-4d48-9c35-a3ac01cd2267

## Fonctionnalités principales

- Ajouter des rappels :

Les utilisateurs peuvent ajouter de nouvelles tâches via une interface simple.

- Marquer les rappels comme terminés :

Un rappel peut être marqué comme complété, avec la possibilité de masquer ou d'afficher les tâches terminées.

- Animation :

Les rappels proposent une animation lors de l'apparition et de la suppression.

- Gestion des données avec SwiftData :

Le modèle de données TaskModel permet de stocker et de récupérer des rappels. Tandis que le fichier TaskController s'occupera de toutes les opérations "CRUD".

- Interface utilisateur intuitive :

L'application adopte une conception simple avec les rappels apparaissant au centre de l'écran. Un tri est effectué automatiquement pour placer en haut les rappels non complétés.

## Détails techniques

- Langages : Swift
- Frameworks : SwiftUI / SwiftData / WidgetKit
- Architecture : MVC
- Version iOS : iOS 17

## Installation

Clonez le projet depuis le dépôt GitHub, puis ouvrez-le dans Xcode. Assurez-vous que vous utilisez la dernière version de Xcode compatible avec Swift 5, SwiftUI et SwiftData pour éviter tout problème de compatibilité.
