---
title: Modules
date: 2018-05-23 19:55:43
---

### modules 由来

1.  AMD

    由客户端 Client 执行;

```js
define(['./a', './b'], function(a, b) {
  // 依赖必须一开始就写好
  a.doSomething();
  // 此处略去 100 行
  b.doSomething();
  // ...
});
require([module], callback);
require(['math'], function(math) {
  math.add(2, 3);
});
```

1.  CommonJS

    在服务端 Server 执行

```js
exports.foo = 1;
// 或者

module.exports = {
  bar: 2,
};

const { foo } = require('a.js');
```

两者的标准并不统一;

1.  ES6

Client + Server 通用模块解决方案;

### Modules 语法

1.  imports

import ImportClause FromClause;
import ModuleSpecifier;

```js
// import v, c from 'mod';
import * as ns from 'mod';
import { x } from 'mod';
import { x as v } from 'mod';
import 'mod'; // 只会执行 mod 模块; 却不会输入任何值;
```

1.  exports

```js
export var v;
export default function() {};
export default function f() {};
export default 42;
export { x };
export { v as x };
export { x } from 'mod';
export { v as x } from 'mod';
export * from 'mod'; // 输出全部模块
```

### Modules 的特性

- 以接口方式暴露, 采用引用类型;
- Module 中也可以 import;

```js
import utils from 'utils';
```

- 模块中 this 是无意义的, 且模块单独一作用域, 外部不可见;

```js
const a = 1;
a === window.a; // false
this === undefined; // true
```

- 同一个模块被引用多次, 只执行一次;

```js
import cookie from utils;
import host from utils;
// 等同于
import host,cookie from utils;
```

### Modules 加载

```html
<script type="module" src="test.js" ></script>

<!-- 对于 type=module 的时候, 默认异步加载 -->
<script type="module" src="test.js" defer></script>

<!-- 加载完成后, 渲染引擎就会中断执行, 此外, 执行完成后, 再恢复渲染 -->
<script type="module" src="test.js" async></script>
```

### Modules 错误范例

```js
export 1; // 1 无法被定义
export  function (){};
export  function f (){};
export class {}

export default var a = 1; // var 和 default 重复定义了 a;
```
