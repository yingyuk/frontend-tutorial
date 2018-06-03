---
title: Iterator
date: 2018-05-23 20:54:43
---

### 可迭代协议

为各种对象提供了统一的访问机制;

```js
const arr = ['a', 'b', 'c'];

for (let item of arr) {
  console.log(item);
}
```

用 for of 循环遍历数组时, 内部其实调用了该数组的 Iterator;

数组的 Iterator 是通过 Symbol.iterator 属性生成的;

```js
const arr = ['a', 'b', 'c'];

const iterator = arr[Symbol.iterator]();

iterator.next(); // { value: 'a', done: false}
iterator.next(); // { value: 'b', done: false}
iterator.next(); // { value: 'c', done: false}
iterator.next(); // { value: undefined, done: true}
```

任意对象, 只要实现了可迭代协议; 它的内部成员就可以通过统一的语法被检索到;

```text
for ... of
拓展运算符
解构赋值
数组
字符串
Map

等等
```

```ts
interface Iterable {
  [Symbol.iterator](): Iterator;
}
```

### Iterator 接口

```ts
interface Iterator {
  next(): IteratorResult;
  return?(): IteratorResult; //  可选; 通常在调用者希望提前结束迭代时调用
  throw?(): IteratorResult; // 可选; 通常在调用者检测到错误时调用
}

interface IteratorResult {
  done: boolean; //  是否迭代完成
  value: any; // 迭代未完成时, 返回当前迭代元素; 迭代完成时, 返回迭代器返回值或缺省
}
```

### 常用可迭代对象

`Array`, `arguments`, `Set`, `Generator`, `Map`, `String`, `TypedArray`

通过实现可迭代协议; 我们也可以自行实现一个可迭代对象

```js
class Foo {
  constructor(items) {
    this.items = items;
  }
  [Symbol.iterator]() {
    let index = 0;
    const { items } = this;
    return {
      next() {
        const item = items[index++];
        if (item) {
          return { value: item, done: false };
        } else {
          return { done: true };
        }
      },
    };
  }
}

const foo = new Foo(['a', 'b', 'c']);

for (let item of foo) {
  console.log(item);
}
```

### 实际应用

1.  拓展运算符

```js
// 拓展运算符语法内部也基于 Iterator
const arr = [1, 2, 3];
console.log(...arr); // 1 2 3
```

可以用来浅复制数组; 将字符串转为数组

```js
const arr = [1, 2, 3];
const arr2 = [...arr];
arr1 === arr2; // false

const str = 'abc';
const arr = [...str]; // ['a', 'b', 'c']
```

1.  字符串处理

```js
// emoji  包含连个字符长度;
const str = '天气晴🌞';

// emoji  包含连个字符长度; 会被拆分
for (let i = 0; i < str.length; i++) {
  console.log(str[i]); // '天' '气' '晴' '�' '�'
}

for (let item of str) {
  console.log(item); // '天' '气' '晴' '🌞'
}
```
