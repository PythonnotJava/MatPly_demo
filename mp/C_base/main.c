#include "matply.h"

int main() {
    set_mult_rand(true);
    double ** gm = uniform(1, 6, .5, 1.0, 1, false);
    visible_data(gm, 1, 6);
    double ** g1m = uniform(1, 6, .5, 1.0, 1, false);
    visible_data(g1m, 1, 6);
 //    [
 //  [0.90675        0.51306         0.69424         0.81701         0.69971         0.79928        ]
 // ]
 // [
 //  [0.90675        0.51306         0.69424         0.81701         0.69971         0.79928        ]
 // ]
}