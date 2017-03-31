import 'package:angel_route/angel_route.dart';

final RegExp _straySlashes = new RegExp(r'(^/+)|(/+$)');

/// Optimizes a router by condensing all its routes into one level.
Router flatten(Router router) {
  var flattened = new Router(debug: router.debug == true)
    ..requestMiddleware.addAll(router.requestMiddleware);

  for (var route in router.routes) {
    if (route is SymlinkRoute) {
      var base = route.path.replaceAll(_straySlashes, '');
      var child = flatten(route.router);
      flattened.requestMiddleware.addAll(child.requestMiddleware);

      for (var route in child.routes) {
        var path = route.path.replaceAll(_straySlashes, '');
        var joined = '$base/$path'.replaceAll(_straySlashes, '');
        flattened.addRoute(route.method, joined.replaceAll(_straySlashes, ''),
            route.handlers.last,
            middleware:
                route.handlers.take(route.handlers.length - 1).toList());
      }
    } else {
      flattened.addRoute(route.method, route.path, route.handlers.last,
          middleware: route.handlers.take(route.handlers.length - 1).toList());
    }
  }

  return flattened;
}
