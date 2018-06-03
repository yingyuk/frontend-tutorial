---
title: Error
date: 2018-05-14 19:43:24
---

# Error

1.  如何创建 Error

    * 创建 Error

    ```js
    new Error(message);
    ```

    * 抛出/捕获 Error

    ```js
    try {
      throw new Error('unexpected error');
    } catch (error) {
      console.log('捕获到错误');
    }
    ```

    * Error 的属性

      * Error.prototype.message

1.  Error 的类型

    * EvalError

      与 eval 函数使用相关; 老版本使用

    * RangeError

      值超出了范围

    * ReferenceError

      无效应用

    * SyntaxError

      语法解析 Error

    * TypeError

      值或参数的类型与预期不符

    * URIError

      未按定义的方式去使用操作 URI 的方法

1.  自定义 Error

```js
function CustomError(message) {
  this.name = 'customError';
  this.message = message || 'Unexpeted Error';
  this.stack = new Error().stack;
}
CustomError.prototype = Object.create(Error.prototype);
CustomError.prototype.construtor = CustomError;
```

测试

```js
try {
  throw new CustomError('测试');
} catch (error) {
  console.log(error.name);
  console.log(error.message);
}
```
