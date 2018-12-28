function distance3d (x, y, z) {
    return Math.sqrt( x*x + y*y + z*z);
}

function distance2d (x, y) {
    return  distance3d(x,y,0);
}

function slope_percent(x,y,z) {
    var dist = distance2d(x,y);
    if (dist > 0 ) {
        return z / dist;
    }
    return undefined
}

function slope_angle(x,y,z) {
    var slope = slope_percent(x,y,z);

    if (slope !== undefined) {
        return Math.atan(slope) * 180.0 / Math.PI;
    }

    return 90.0;
}
