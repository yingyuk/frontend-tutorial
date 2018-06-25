---
title: Generator
date: 2018-05-23 20:59:43
---

generator 生成器

```js
function* generatorFunc() {
  const a = yield 'a';
  console.log('a is :', a);
  yield 'b';
  yield 'c';
}
const generatorObj = generatorFunc();
generatorObj.next(); // { value: 'a', done: false }
generatorObj.next('foo'); // a is : foo
// { value: 'b', done: false }
generatorObj.next(); // { value: 'c', done: false }
generatorObj.next(); // { value: undefined, done: true }
```

| 普通函数           | Generator 函数     |
| ------------------ | ------------------ |
| 语法 function(){}  | function \* (){}   |
| 一次执行, 不能暂停 | 分段执行, 可暂停   |
| 返回(return)一个值 | 返回(yield) 多个值 |

### generator 对象

next 方法可以恢复 generator 的执行, 还能动态的传入数据;
从而调整 generator 的执行;

### Generator 与 Iterator

Generator 对象 实现了 Iterator 的接口和协议;

GeneratorObj.next;
GeneratorObj.return;
GeneratorObj.throw;

GeneratorObj[Sybmol.iterator]

由于 Generator 实现了 Sybmol.iterator 属性, 我们可以通过 for ... of 拓展运算符来自动执行它;
不需要手动调用 next 方法;

```js
function* generatorFunc() {
  yield 'a';
  yield 'b';
  yield 'c';
}
const generatorObj = generatorFunc();
console.log(...generatorObj);
// a b c
```

### 应用场景: 实现可迭代对象

```js
class Foo {
  constructor(items) {
    this.items = items;
  }
  *[Symbol.iterator]() {
    for (const item of this.items) {
      yield item;
    }
  }
}
const foo = new Foo(['a', 'b', 'c']);
console.log(...foo);
// a b c
```

### 非线性迭代

yield \* 关键字后面可以跟随另一个 Generate 对象或其他可迭代对象;
可以利用这个特性实现 非线性结构的遍历;

```js
function* a() {
  yield 'a1';
  yield 'a2';
}
function* b() {
  yield 'b1';
  yield* [1, 2];
  yield* a();
  yield 'b2';
}

for (let item of b()) {
  console.log(item);
}
// b1
// 1
// 2
// a1
// a2
// b2
```

比如二叉树的先序遍历

```js
class BinaryTree {
  constructor(value, leftChild = null, rightChild = null) {
    this.value = value;
    this.leftChild = leftChild;
    this.rightChild = rightChild;
  }
  *[Symbol.iterator]() {
    //  遍历当前节点
    yield this.value;

    if (this.leftChild) {
      //  遍历左子树
      yield* this.leftChild;
    }
    if (this.rightChild) {
      //  遍历右子树
      yield* this.rightChild;
    }
  }
}
```

### 协程

协程: 控制权的主动让出;

程序自身可以控制各个子程序的切换;
让异步代码看上去更加像同步代码;

```js
// 生产者
function* producerGen() {
  while (true) {
    // const data = produceData();
    const data = Math.random();
    yield data;
  }
}
// 消费者
function consumer() {
  const producer = producerGen();
  while (true) {
    data = producer.next().value;
    // todo(data); // 处理数据
    console.log('data', data);
  }
}
consumer();
```
