# DEPRECATED
The functionality formerly offered by this package has long been rolled in `package:angel_route`.

# flatten
[![version 1.0.0](https://img.shields.io/badge/pub-1.0.0-brightgreen.svg)](https://pub.dartlang.org/packages/flatten)
[![build status](https://travis-ci.org/angel-dart/flatten.svg)](https://travis-ci.org/angel-dart/flatten)

Optimizes a router by condensing all its routes into one level.
This only works with `package:angel_route`.

`package:angel_route` is an ultra-powerful router that works across all platforms.
It supports nested groups, and an advanced middleware system. The caveat is, route groups
and middleware exist at different levels within the hierarchy when nested. Flattening
a router condenses all routes into one level, and inlines route handlers, so that paths
can be resolved much faster.

The Angel framework uses a flattened router in production mode to optimize servers.

# Installation
In your `pubspec.yaml`:

```yaml
dependencies:
  angel_route: ^1.0.0
  flatten: ^1.0.0
```

# Usage
import 'package:angel_route/angel_route.dart';
import 'package:flatten/flatten.dart';

```dart
var flattened = flatten(myRouter);
```

# Caveats
This package doesn't actually modify the existing router; instead, it
creates a new one. Routes adding to the original router after flattening
will not be present in the new router.
