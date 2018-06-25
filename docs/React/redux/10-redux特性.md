### 为什么需要 redux

store -> dom

redux 核心的出发点是让 组件通讯更加容易;
不需要层层传递消息; 通过 store 来通讯;

在没有 redux 下的 MVC 架构下, 一个 View 可能使用多个 Model, 一个 Model 也可能对应多个 View, 关系错综复杂, 难以追踪;

### redux 特性

1.  Single Source of Truth

    所有的 View 都是依赖 Store; Store 数据变化会让 View 更新, View 通过事件通知 Store 变化;

1.  可预测性

    state + action = new state

    它要产生新状态 一定是由 action 触发的, 有了 action 一定会产生一个新的 state (不可变数据), 而不是在原来的 state 上修改;

1.  纯函数更新 Store

    当我们需要更新一个 redux 的 store 时;
    我们需要
    通过一个 action 来触发更新;
    通过一个 reducer 的函数 来产生一个新的 store;

    纯函数: 输出结果完全取决于输入参数; 函数内部不依赖于任何的外部参数, 外部资源; 这样的函数是非常容易预测和测试的;
