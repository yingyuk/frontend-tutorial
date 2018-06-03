---
title: Promise
date: 2018-05-23 20:12:43
---

### Promise 对象

1.  一个 promise 代表一次异步操作

1.  生成后立即执行

pengding -> Fulfilled 成功
pengding -> Rejected 失败

1.  then(), catch()

then 接收两个函数作为参数; 当有第二个参数时, 将会捕获错误;
后续的逻辑将会继续执行; 并且这个错误不会再被 catch 捕获;

```js
const pro = Promise.reject(10)
  .then(
    data => {
      console.log('ok', data);
      return 20;
    },
    err => {
      console.log('not ok', err); // 'not ok' 10
      return 30;
    }
  )
  .then(
    data => {
      console.log('ok', data); // 'ok' 30
      return 40;
    },
    err => {
      console.log('not ok', err);
    }
  )
  .catch(err => {
    console.log('catch error', err);
  });
pro; //   Promise {<resolved>: 40}
```

### promise 静态方法

1.  创建 Promise 对象

    * Promise.resolve('ok')

      ```js
      Promise.resolve('ok');
      // 等同于 ===
      new Promise(resolve => resolve('ok'));
      ```

    * Promise.reject()

1.  并行执行异步操作, 并生成新的 Promise 对象

    * Promise.all([ Promise ])

      返回一个新的 Promise;

      当数组里有一个 Rejected 状态时; 则新对象为 Rejected;
      当数组里 所有对象为 Fulfilled 状态时; 则新对象为 Fulfilled;

    * Promise.race()


      返回一个新的 Promise;

      当数组里有一个 Rejected 状态时; 则新对象为 Rejected;
      当数组里有一个对象为 Fulfilled 状态时; 则新对象为 Fulfilled;

### 对比传统异步操作

1.  侵入性

    * 回调函数

      ```js
      fs.readFile('/filepath', (err, data) => {
        // todo
      });
      ```

      异步方法必须现实的调用回调方法;
      代码具有一定的耦合性;

      参数的职责也不够清晰; 既用作异步方法的逻辑处理; 又用作执行完后的回调处理;

      多个异步串联将会导致回调地狱;

    - Promise

      ```js
      readFilePromise('/filepath')
        .then(data => {
          // todo
        })
        .catch(err => {
          // todo
        });
      ```

      对异步方法本身没有任何侵入性;

      多个异步可以链式调用;

### 状态固化

```js
const eventBus = {
  task: [],
  on(name, callback) {
    const task = this.tasks.find(item => item.name === name);
    if (task) {
      task.handlers.push(callback);
    } else {
      this.tasks.push({ name, handlers: [callback] });
    }
  },
  emit(name, ...args) {
    const task = this.tasks.find(item => item.name === name);
    if (task) {
      task.handlers.forEach(callback => {
        callback(...args);
      });
    }
  },
};

eventBus.emit('foo', 'hello');

// 在事件监听前 emit 事件;
// 事件触发后, 无法监听到
eventBus.on('foo', value => {
  console.log('capture event foo ', value);
});
```

Promise 对象进入完成状态是, 状态将会固化;

因此 Promise 对象完成前后, 可以获得一样的执行结果

```js
const timeout = new Promise(resolve => setTimeout(resolve, 100));

timeout.then(value => {
  console.log('sucess');
});

setTimeout(() => {
  timeout.then(value => {
    console.log('sucess again');
  });
}, 1000);
```

### 实践

1.  使用 catch 代替 reject handler

catch 除了可以处理 reject 状态; 还可以捕获 then 函数中的代码异常;

1.  同步代码异步化

1.  Promise 链式调用

1.  避免断链

then 函数中返回一个新的 Promise;

1.  用 Promise.all, Promise.race 处理异步集合
