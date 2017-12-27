import { NativeModules } from 'react-native';

var CuteTouchIDModule = NativeModules.CuteTouchID;

module.exports = {
    authenticate: CuteTouchIDModule.authenticate,
    isSupported: CuteTouchIDModule.isSupported
}