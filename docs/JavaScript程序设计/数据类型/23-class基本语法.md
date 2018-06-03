---
title: class 基本语法
date: 2018-05-22 19:52:43
---

### class 简介

早期的定义

```js
function ES5() {
  this.a = a;
  this.b = b;
}
ES5.prototype.func = function() {
  return this.a + this.b;
};

var result = new ES5(1, 2);
```

```js
class ES6 {
  constructor(a, b) {
    this.a = a;
    this.b = b;
  }
  func() {
    return this.a + this.b;
  }
}
var result = new ES6(1, 2);
```

语法糖

### class 特性

1.  共性

实例化

```js
var a = new ES5();
var b = new ES6();

var c = ES5();
var d = ES6(); // throw error
```

同于 构造函数

```js
class ES6 {
  constructor() {
    this.foo = 'bar';
  }
  func() {
    return this.a + this.b;
  }
}

typeof ES6; // 'function'
ES6 === ES6.prototype.constructor; // true

var b = new ES6();
b.constructor === ES6.prototype.constructor; // true
```

给类赋予更多方法

```js
class ES6 {}

// 给类赋予更多方法
Object.assign(ES6, {
  newFunc() {},
  newFunc2() {},
});
```

1.  差异

```js
class ES6 {
  constructor() {}
  newFunc() {},
  newFunc2() {},
}

Object.keys(ES6.prototype); // []

Object.getOwnPropertyNames(ES6.prototype); // [ 'constructor', 'newFunc', 'newFunc2']
```

可枚举

```js
function ES5() {}

Object.assign(ES5, {
  newFunc() {},
  newFunc2() {},
});
Object.keys(ES5.prototype); // [ 'newFunc', 'newFunc2']

Object.getOwnPropertyNames(ES5.prototype); // [ 'constructor', 'newFunc', 'newFunc2']
```

默认使用严格模式;

### class 表达式

class 内部定义

```js
const ES6 = class inside {
  getName() {
    // inside 只能在内部被引用
    console.log(inside.name);
  }
};
let _es6 = new ES6();

_es6.getName(); // inside

inside.name; // ReferenceError: inside is not defined
```

class 不可以重复声明; 会报错

class 变量提升

```js
new ES5();
function ES5() {}

new ES6(); // ReferenceError: ES6 is not defined
class ES6 {}
```

### class static

1.  实例无法调用 static 方法

静态方法可以保护某些方法不背实例使用

```js
const ES6 = class {
  constructor() {}
  static getName() {
    console.log(this.name);
  }
};
ES6.getName;

const _es6 = new ES6();
_es6.getName; // undefined
```

1.  static 内的 this 是指向类的;

```js
const ES6 = class {
  constructor() {}
  static name(){
    this.getName();
  }
  static getName() {
    // 被调用
    console.log('name');
  },
  getName(){
    console.log('new name')
  }
};
ES6.name(); // 'name'
```

1.  继承包含 static

```js
const ES6 = class {
  constructor() {}
  static getName() {
    console.log('name');
  },
  getNewName(){
    console.log('new name')
  }
};

class ES6_child extends ES6{
  static getName(){
    console.log(super.getName() + ' child')
  }
}
ES6_child.getNewName(); // 'new name' // 顺着原型链查找
ES6_child.getName(); // 'name child'
```

static 只有静态方法; 没有静态属性;

在 class 中的同名方法; static func 优先 func 调用;

实例无法调用 static func;

### new.target

ES5 中的 new.target

```js
function ES5(){
  if(!new.target){
    throw nwe Error('must be new ES5')
  }
}
ES5(); // Error
```

class 中的 new.target;

class 中的 new.target 指向的是子类;

```js
class Polygon {
  constructor() {
    const result = new.target === Polygon ? 'success' : 'fail';
    console.log(result);
  }
}

class Square extends Polygon {
  constructor() {
    super();
  }
}

let polygon = new Polygon(); // 'success'
let square = new Square(); // 'fail'
```
