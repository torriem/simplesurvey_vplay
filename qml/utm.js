    const K0 = 0.9996

    const E = 0.00669438
    const E2 = E * E
    const E3 = E2 * E
    const E_P2 = E / (1.0 - E)

    const SQRT_E = Math.sqrt(1 - E)
    const _E = (1 - SQRT_E) / (1 + SQRT_E)
    const _E2 = _E * _E
    const _E3 = _E2 * _E
    const _E4 = _E3 * _E
    const _E5 = _E4 * _E

    const M1 = (1 - E / 4 - 3 * E2 / 64 - 5 * E3 / 256)
    const M2 = (3 * E / 8 + 3 * E2 / 32 + 45 * E3 / 1024)
    const M3 = (15 * E2 / 256 + 45 * E3 / 1024)
    const M4 = (35 * E3 / 3072)

    const P2 = (3. / 2 * _E - 27. / 32 * _E3 + 269. / 512 * _E5)
    const P3 = (21. / 16 * _E2 - 55. / 32 * _E4)
    const P4 = (151. / 96 * _E3 - 417. / 128 * _E5)
    const P5 = (1097. / 512 * _E4)

    const R = 6378137

    function utz_pseudo_zone (lat, lon) {
        if (56 <= lat && lat < 64 &&
                3 <= lon && lon < 12)
            return 32;

        if (72 <= lat && lat <=84 &&
                lon >=0) {
            if (lon <= 9)  return 31;
            if (lon <= 21) return 33;
            if (lon <= 33) return 35;
            if (lon <= 42) return 37;
        }

        return (lon + 180.0) / 6.0 + 1 - 0.5;
    }

    function from_latlon(latitude, longitude, central_lon) {
        var R = 6378137

        if (! (-80.0 <= latitude && latitude <= 84.0))
            //utm only works between -80 and 84 degrees latitude
            return {easting: undefined, northing: undefined}
        if (! (-180.0 <= longitude && longitude <= 180.0))
            //longitude must be valid
            return {easting: undefined, northing: undefined}

        var lat_rad = latitude * Math.PI / 180.0
        var lat_sin = Math.sin(lat_rad)
        var lat_sin2 = lat_sin * lat_sin
        var lat_cos = Math.cos(lat_rad)
        var lat_cos2 = lat_cos * lat_cos

        var lat_tan = lat_sin / lat_cos
        var lat_tan2 = lat_tan * lat_tan
        var lat_tan4 = lat_tan2 * lat_tan2

        var lon_rad = longitude * Math.PI / 180.0
        var central_lon_rad = central_lon * Math.PI / 180.0

        var n = R / Math.sqrt(1 - E * lat_sin2)
        var c = E_P2 * lat_cos2

        var a = lat_cos * (lon_rad - central_lon_rad)
        var a2 = a * a
        var a3 = a2 * a
        var a4 = a3 * a
        var a5 = a4 * a
        var a6 = a5 * a

        var m = R * (M1 * lat_rad -
                     M2 * Math.sin(2 * lat_rad) +
                     M3 * Math.sin(4 * lat_rad) -
                     M4 * Math.sin(6 * lat_rad))

        var easting = K0 * n * (a +
                            a3 / 6 * (1 - lat_tan2 + c) +
                            a5 / 120 * (5 - 18 * lat_tan2 + lat_tan4 + 72 * c - 58 * E_P2)) + 500000;
        var northing = K0 * (m + n * lat_tan * (a2 / 2 +
                                            a4 / 24 * (5 - lat_tan2 + 9 * c + 4 * c * c) +
                                            a6 / 720 * (61 - 58 * lat_tan2 + lat_tan4 + 600 * c - 330 * E_P2)))

        if (latitude < 0) northing += 10000000

        return {easting: easting, northing: northing}
    }
