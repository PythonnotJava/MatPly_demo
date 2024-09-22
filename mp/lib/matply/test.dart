import 'dart:math' as math;

import 'matply.dart';

main(){
  initMp();
  set_visible_round('%.2f');
  List<List<double>> data = [
    [9, 6, 5, 0, 3, 4, 8, 5, 5, 1],
    [3, 6, 5, 2, 2, 3, 7, 8, 9, 1]
  ];
  MatrixType mt = MatrixType(data);
  MatrixType mt1 = mt.sort(dim: -1);
  mt1.visible();
  mt.visible();
  mt.sort().visible();
  mt.shuffle();
  mt.visible();
  freeMp(visible: true);
  math.Point(2.4, 33).toPoint2d;
}

/*output MatrixType mt1 = MatrixType.dirichlet(alpha:[1.2, 3, 0.5], size: 10);
  mt1.visible();
  print(mt1.flatten_list());
  freeMp(visible: true, hex: true);
[
 [0.25622 0.28209 0.25044 0.43373 0.29696 0.69026 0.59955 0.26258 0.29329]
 [1.25087 1.57323 0.30614 0.44101 0.25149 0.30327 0.29911 0.98868 2.15261]
]
Free Memory in location : 000002f0d1f97350
 */