## React Native Cute TouchID
[![react-native version](https://img.shields.io/badge/react--native-0.43-blue.svg?style=flat-square)](http://facebook.github.io/react-native/releases/0.43)
[![npm version](https://img.shields.io/npm/v/react-native-cute-touch-id.svg?style=flat-square)](https://www.npmjs.com/package/react-native-cute-touch-id)
[![npm downloads](https://img.shields.io/npm/dm/react-native-cute-touch-id.svg?style=flat-square)](https://www.npmjs.com/package/react-native-cute-touch-id)
A small react-native plugin which offers app touch ID ability.

**Cute TouchID** is able to **detect changes of touch ID's additions or deletions** which is important to apps in high security level.

![example](https://raw.githubusercontent.com/captainwz/react-native-cute-touch-id/master/touchid.gif)

### Notice

Only support IOS by now.

React Native > 0.43

### Installation
```shell
npm install --save react-native-cute-touch-id

react-native link
```

### Usage
```jsx
import CuteTouchID from 'react-native-cute-touch-id';
```

To detect if Touch ID is available

```jsx
CuteTouchID
.isSupported()
.then(success => {
	// supported
})
.catch(e => {
	// not supported
})
```

To authenticate

```jsx
CuteTouchID
.authenticate('My Authenticate Reason')
.then(success => {
	// success
})
.catch(e => {
	// error happens
})
```

### Error Types
* TOUCH ID CHANGED
* AUTHENTICATION FAILED
* APP CANCEL
* INVALID CONTEXT
* NOT INTERACTIVE
* PASS CODE NOT SET
* SYSTEM CANCEL
* USER CANCEL
* USER FALLBACK
* BIOMETRY LOCKOUT
* BIOMETRY NOT ENROLLED
* BIOMETRY NOT AVAILABLE
* UNKNOWN ERROR

### Lisence
MIT
