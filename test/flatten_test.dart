import 'package:angel_route/angel_route.dart';
import 'package:flatten/flatten.dart';
import 'package:test/test.dart';

main() {
  Router router;

  setUp(() async {
    var inner = new Router()
      ..get('/////a', 'a', middleware: ['z'])
      ..get('/b/c////', 'd')
      ..chain(['a', 'b', 'c', 'd']).group('/e', (router) {
        router
          ..get('/f', 'g')
          ..group('/////h', (router) {
            router.chain('i')..get('/j///', 'k')..get('/l/:id', 'm');
          });
      });

    router = flatten(inner..dumpTree(header: 'Original route tree:'))
      ..dumpTree(header: 'Flattened route tree:');
  });

  test('resolve', () {
    var m = router.resolve('/e/h/l/test', '/e/h/l/test');
    expect(m.handlers, equals(['a', 'b', 'c', 'd', 'i', 'm']));
    expect(m.params, equals({'id': 'test'}));

    var j = router.resolve('/e/h/j', '/e/h/j');
    expect(j.handlers, equals(['a', 'b', 'c', 'd', 'i', 'k']));

    var d = router.resolve('/b/c', '/b/c');
    expect(d.handlers, equals(['d']));

    var a = router.resolve('/a', '/a');
    expect(a.handlers, equals(['z', 'a']));
  });
}
