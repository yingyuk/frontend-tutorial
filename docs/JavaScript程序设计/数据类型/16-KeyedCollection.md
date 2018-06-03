---
title: KeyedCollection
date: 2018-05-14 21:25:52
---

# KeyedCollection

### Map

```js
// new Map([iterable]);
// 接受键值对数组 组成的数组

const a = new Map([
  [0, 'zero'],
  [1, 'one'],
  // [key, value]
]);
```

1.  Map 与 Object 区别

    | Object                                   | Map                              |
    | ---------------------------------------- | -------------------------------- |
    | 键值只能是字符串或者                     | 键值可以是任意值                 |
    | 需要通过 for...in 语句手动获得键值对个数 | 可以通过 size 属性获得键值对个数 |

1.  Map 原型方法

    * Map.prototype.set(key, value)

      返回该 Map 对象; 可以链式调用

    * Map.prototype.get(key)

      返回键对应的值, 如果不存在, 则为 undefined;

    * Map.prototype.has(key)

      返回一个布尔值, 表示 Map 实例是否包含这个键值;

    * Map.prototype.delete(key)

      移除任何与键相关联的值，并且返回该值;

    * Map.prototype.clear()

      移除 Map 对象的所有键/值对 。

    * Map.prototype.forEach(callbackFn[, thisArg])

      按插入顺序，为 Map 对象里的每一键值对调用一次 callbackFn 函数。如果为 forEach 提供了 thisArg，它将在每次回调中作为 this 值。

    * Map.prototype.entries()

      返回一个新的 Iterator 对象，它按插入顺序包含了 Map 对象中每个元素的值 。

    * Map.prototype.keys()

      返回一个新的 Iterator 对象， 它按插入顺序包含了 Map 对象中每个元素的键

    * Map.prototype.size

      返回 Map 对象的键/值对的数量。

### WeakMap

WeakMap 的键是弱引用的; 它的键是必须是对象; 而值可以是任意的。

```js
new WeakMap([iterable]);
```

| WeakMap                                  | Map              |
| ---------------------------------------- | ---------------- |
| 键名只能是对象                           | 键名可以是任意值 |
| 键名所指向的对象, **不计入**垃圾回收机制 | 计入垃圾回收机制 |
| 键名是**非枚举**的                       | 键名是可枚举的   |

因为是不计入垃圾回收机制; 所以是非枚举的;
如果是可枚举; 键被垃圾回收了; 键值会发生变化; 会得到不确定的结果, 那将会产生问题; 所以是非枚举的;

1.  属性和方法

* WeakMap.prototype.delete(key)

移除 key 的关联对象;

* WeakMap.prototype.get(key)

返回 key 关联对象, 或者 undefined(没有 key 关联对象时)。

* WeakMap.prototype.has(key)

根据是否有 key 关联对象返回一个 Boolean 值。

* WeakMap.prototype.set(key, value)

在 WeakMap 中设置一组 key 关联对象，返回这个 WeakMap 对象。

1.  WeakMap 的作用

避免内存泄露

### Set

```js
// new Set([iterable]);
const s = new Set([1, 2, 3, 1, 2, 3]);
```

1.  原型和方法

* Set.prototype.size
  返回 Set 对象的值的个数。

* Set.prototype.add(value)
  在 Set 对象尾部添加一个元素。返回该 Set 对象。

* Set.prototype.clear()
  移除 Set 对象内的所有元素。

* Set.prototype.delete(value)
  移除 Set 的中与这个值相等的元素，返回 Set.prototype.has(value);

* Set.prototype.entries()
  返回一个新的迭代器对象，该对象包含 Set 对象中的按插入顺序排列的所有元素的值的[value, value]数组

* Set.prototype.has(value)
  返回一个布尔值，表示该值在 Set 中存在与否。

* Set.prototype.values()
  返回一个新的迭代器对象

* Set.prototype.forEach(callbackFn[, thisArg])
  按照插入顺序，为 Set 对象中的每一个值调用一次 callBackFn。如果提供了 thisArg 参数，回调中的 this 会是这个参数。

### WeakSet

WeakSet 对象允许你将弱保持对象存储在一个集合中。

```js
// new WeakSet([iterable]);
```

| WeakSet                                  | Set              |
| ---------------------------------------- | ---------------- |
| 键名只能是对象                           | 键名可以是任意值 |
| 键名所指向的对象, **不计入**垃圾回收机制 | 计入垃圾回收机制 |
| 键名是**非枚举**的                       | 键名是可枚举的   |

1.  WeakSet 的方法

* WeakSet.prototype.add(value)
  在该 WeakSet 对象中添加一个新元素 value.

* WeakSet.prototype.clear()
  清空该 WeakSet 对象中的所有元素.

* WeakSet.prototype.delete(value)
  从该 WeakSet 对象中删除 value 这个元素, 之后 WeakSet.prototype.has(value) 方法便会返回 false.

* WeakSet.prototype.has(value)
  返回一个布尔值, 表示给定的值 value 是否存在于这个 WeakSet 中.
