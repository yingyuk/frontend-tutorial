---
title: class 继承
date: 2018-05-22 20:47:43
---

### 继承

`ES5 组合继承` VS `ES6 extends`

```js
class Company {}

class Google extends Company {
  constructor(name) {
    super();
  }
}
```

子类必须在 constructor 中调用 super; 否则报错;

```js
class Company {}

class Google extends Company {
  constructor(name) {
    // 这个时候 Google 没有 this; 应该从 Company 继承过来
    // 通过 super 的方法; 把 Company 的属性方法继承过来;
  }
}
new Google();
// ReferenceError: Must call super constructor in derived class before accessing 'this' or returning from derived constructor
```

```js
class Company {}

class Google extends Company {
  constructor(name) {
    this.name = name; // ReferenceError; super 还没有调用; 所以还没有 this;
    super(); // 开始继承

    // 应该先 super, 再使用 this
  }
}
new Google();
```

判断父子继承关系

```js
Object.getPrototypeOf(Google) === Company;
```

### super

```js
super([arguments]); // 调父类的 constructor; 需要在 constructor 内才能调用

super.functionOnParent([arguments]);
```

```js
class Company {}

class Google extends Company {
  constructor(name) {
    super(); // 开始继承
    // 不能直接输出 super
    console.log(super); // error
  }
  test(){
    // 需要在 constructor 内才能调用
    super(); // error
  }
}
new Google();
```

```js
class Company {
  sayHi() {
    console.log('hi');
  }
}

class Google extends Company {
  constructor(name) {
    super(); // 开始继承
    console.log(super.sayHi === Google.prototype.sayHi);
  }
  test() {
    super.sayHi();
  }
}

const google = new Google(); // true
google.test(); // 'hi'
```

super "基本上" 等同于 Company.prototype;

```js
class Company {
  constructor(name) {
    this.age = 10;
  }
}

class Google extends Company {
  constructor(name) {
    super(); // 开始继承

    // Company.age
    console.log(this.age); // 10

    // this.__proto__.age
    console.log(super.age); // undefined

    this.age = 20; // google.age = 20
    console.log(this.age); // 20

    /**
     * 通过 super 对某个属性赋值时, super 等同于 this;
     * 所以这是等同于 this.age = 30;
     */
    super.age = 30;

    /**
     * console.log(this.__proto__.age, google.age);
     */
    console.log(super.age, this.age); // undefined, 30
  }
}

const google = new Google();
```

通过 super 对某个属性赋值时, super 等同于 this;

不能 delete super.func; 会报错; 父类的方法不能删除;

### extends

1.  另一种 extends

```js
class Company {}

class Google extends Company {
  constructor() {
    super();
  }
}

Google.__proto__ === Company; // true

Google.prototype.__proto__ === Company.prototype; // true
```

等同于:

```js
class Company {}
class Google {}

Google.__proto__ = Company;
Google.prototype.__proto__ = Company.prototype;
```

```js
function setPrototypeOf(obj, proto) {
  obj.__proto__ = proto;
  return obj;
}

Object.setPrototypeOf(Google.prototype, Company.prototype);
// Google.prototype.__proto__ = Company.prototype;

Object.setPrototypeOf(Google, Company);
// Google.__proto__ = Company;
```
