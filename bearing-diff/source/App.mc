using Toybox.Activity as Activity;
using Toybox.Application as App;
using Toybox.Math as Math;
using Toybox.WatchUi as Ui;

class BearingDiffApp extends App.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [new BearingDiffField()];
    }
}

class BearingDiffField extends Ui.SimpleDataField {
    var _buffer;
    var _idx;

    function initialize() {
        SimpleDataField.initialize();
        label = "Brg Diff";
        _buffer = new [3];
        _idx = 0;
    }

    function compute(info) {
        if (info.bearing == null || info.track == null) {
            return "---";
        }
        var thetaRad = info.bearing - info.track;
        var thetaDeg = thetaRad * 180 / Math.PI;
        if (thetaDeg > 180) {
            thetaDeg -= 360;
        } else if (thetaDeg < -180) {
            thetaDeg += 360;
        }
        _buffer[_idx] = thetaDeg;
        _idx = (_idx + 1) % 3;
        var sum = 0.0;
        var count = 0;
        for (var i = 0; i < 3; i++) {
            if (_buffer[i] != null) {
                sum += _buffer[i];
                count++;
            }
        }
        return (sum / count).toNumber().format("%d") + "\u00B0";
    }
}
