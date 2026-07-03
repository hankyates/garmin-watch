using Toybox.Activity as Activity;
using Toybox.Application as App;
using Toybox.Math as Math;
using Toybox.WatchUi as Ui;

class VMGApp extends App.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [new VMGField()];
    }
}

class VMGField extends Ui.SimpleDataField {
    var _buffer;
    var _idx;

    function initialize() {
        SimpleDataField.initialize();
        label = "VMG";
        _buffer = new [3];
        _idx = 0;
    }

    function compute(info) {
        if (info.bearing == null || info.track == null || info.currentSpeed == null) {
            return "---";
        }
        var theta = info.bearing - info.track;
        var vmgMs = Math.cos(theta) * info.currentSpeed;
        var vmgKnots = vmgMs * 1.94384;
        _buffer[_idx] = vmgKnots;
        _idx = (_idx + 1) % 3;
        var sum = 0.0;
        var count = 0;
        for (var i = 0; i < 3; i++) {
            if (_buffer[i] != null) {
                sum += _buffer[i];
                count++;
            }
        }
        return (sum / count).format("%.1f") + " kn";
    }
}
