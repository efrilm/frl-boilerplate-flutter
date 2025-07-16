# FRL Boilerplate CLI 🚀

**FRL Boilerplate CLI** is a simple Dart command-line tool to quickly bootstrap Flutter projects with Clean Architecture structure and predefined dependencies.

It helps you:

- Initialize a Flutter project with essential packages
- Generate domain and feature boilerplates
- Maintain consistent project structure
- Save hours of manual setup

---

## ✨ Features

✅ Add latest versions of recommended packages  
✅ Auto-generate Clean Architecture folders (domain, data, presentation)  
✅ Support BLoC pattern  
✅ Generate launcher_icon.yaml  
✅ Configures flutter_gen automatically  
✅ Clean and colorful CLI output

---

## 📦 Packages Installed

- auto_route
- connectivity_plus
- data_channel
- dio
- get_it
- freezed_annotation
- injectable
- intl
- json_annotation
- path
- path_provider
- json_serializable
- dartz
- flutter_svg

**Dev dependencies:**

- auto_route_generator
- build_runner
- freezed
- awesome_dio_interceptor
- injectable_generator
- flutter_gen_runner
- flutter_launcher_icons

All dependencies are fetched dynamically from pub.dev to ensure you get the latest versions.

---

## 🚀 Getting Started

### Install Dependencies

If your project is new:

```bash
dart pub get
```

---

### Initialize the Project

Run:

```bash
dart run frl_boilerplate init
```

This command:

- Adds recommended dependencies
- Generates `launcher_icon.yaml`
- Configures `flutter_gen`
- Runs `dart pub get`

---

### Generate Domain

Create a domain layer structure for an entity, e.g. `user`:

```bash
dart run frl_boilerplate create-domain user
```

This generates:

```
lib/domain/user/
├── entities/
│   └── user.dart
├── repository/
│   └── user_repository.dart
└── usecases/
    └── get_user.dart
```

---

### Generate Feature

Create a feature structure for a specific feature, e.g. `auth`:

```bash
dart run frl_boilerplate create-feature auth
```

This generates:

```
lib/features/auth/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repository/
├── domain/
│   ├── entities/
│   ├── repository/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

---

## 🛠️ Additional Commands

### Run Flutter Launcher Icons

After initializing, generate your app icons by running:

```bash
dart run flutter_launcher_icons -f launcher_icon.yaml
```

---

## 📂 Recommended Project Structure

Here’s an example of the structure after using this CLI:

```
lib/
├── core/
│   ├── constants/
│   └── logger.dart
├── domain/
│   └── ...
├── features/
│   └── ...
├── shared/
│   └── ...
└── main.dart
```

---

## 💻 Development

### Run Tests

```bash
dart test
```

### Format Code

```bash
dart format .
```

---

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Open an issue
- Submit a pull request
- Suggest improvements

---

## 📄 License

MIT License

---

## 🔗 Related Links

- [Dart CLI Documentation](https://dart.dev/tools/dart-cli)
- [Flutter Documentation](https://flutter.dev/docs)

---

## 📸 Screenshot

> Add screenshots of your CLI output here for a nice README visual!

Example output:

```
🔹 Adding dependencies...
✅ dio: ^5.4.0 added.
⏭️  get_it already exists, skipping...

🔹 Running dart pub get...
Resolving dependencies...
✅ All done!
```

---

## ⚙️ Project Scaffolding

The FRL Boilerplate CLI helps you quickly scaffold common project structure.

### Create `lib/common` Folders

Generate standard folders for shared code using:

```bash
dart run frl_boilerplate create-common
```

This creates:

```
lib/common/
├── api/
├── constants/
├── di/
├── extension/
├── formatter/
├── function/
├── network/
├── resources/
├── url/
├── validator/
└── components/
```

Use this folder for reusable, project-wide utilities, constants, components, and helpers.

Example CLI output:

```
──────────── Create common folder... ────────────
✅ Created folder: api
✅ Created folder: constants
✅ Created folder: di
✅ Created folder: extension
✅ Created folder: formatter
✅ Created folder: function
✅ Created folder: network
✅ Created folder: resources
✅ Created folder: url
✅ Created folder: validator
✅ Created folder: components
✅ Create common folder Success
```

---

## 🌐 Environment Configuration

FRL Boilerplate CLI also generates an environment configuration for dependency injection:

Generate your environment file with:

```bash
dart run frl_boilerplate create-env
```

This creates:

```
lib/shared/env/env.dart
```

Default content:

```dart
import 'package:injectable/injectable.dart';

abstract class Env {
  String get baseUrl;
  // add getter here...
}

@Injectable(as: Env)
@dev
class DevEnv implements Env {
  @override
  String get baseUrl => '';
}

@Injectable(as: Env)
@prod
class ProdEnv implements Env {
  @override
  String get baseUrl => '';
}
```

You can extend this class with additional environment-specific configurations, such as:

- API keys
- Analytics tokens
- Feature toggles
- Third-party service URLs

Example CLI output:

```
──────────── Generating env.dart... ────────────
✅ Created folder: lib
✅ env.dart generated at: lib/env.dart
```

---

## 🎨 Assets Setup

FRL Boilerplate CLI helps you organize and register assets automatically.

### Default Asset Folders

These folders will be created under your project root:

```
assets/
├── images/
├── icons/
├── fonts/
└── json/
```

---

### Automatically Update pubspec.yaml

When you run:

```bash
dart run frl_boilerplate init
```

The CLI will:

✅ Create these asset folders if they don’t exist  
✅ Automatically add the asset paths into your `pubspec.yaml`

---

### Example pubspec.yaml Changes

After running the CLI, your `pubspec.yaml` will look like this:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
    - assets/fonts/
    - assets/json/
```

If you’re using custom fonts, you can also extend the fonts section:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
    - assets/fonts/
    - assets/json/

  fonts:
    - family: MyFont
      fonts:
        - asset: assets/fonts/MyFont-Regular.ttf
```

---

## 📂 Project Structure Including Assets

Here’s an example structure after running `frl_boilerplate init`:

```
lib/
└── main.dart
assets/
├── images/
├── icons/
├── fonts/
└── json/
pubspec.yaml
```

---

## 📸 Screenshot

Example output from the CLI:

```
──────────── Create asset folders... ────────────
✅ Created folder: assets/images
✅ Created folder: assets/icons
✅ Created folder: assets/fonts
✅ Created folder: assets/json
✅ Added asset path to pubspec.yaml: assets/images/
✅ Added asset path to pubspec.yaml: assets/icons/
✅ Added asset path to pubspec.yaml: assets/fonts/
✅ Added asset path to pubspec.yaml: assets/json/
✅ pubspec.yaml updated with asset paths.
```
