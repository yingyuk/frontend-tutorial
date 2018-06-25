# 理解 Store,Action,Reducer

### Store

```js
const store = createStore(reducer);
```

1.  getState()

    得到当前 state 数据

1.  dispatch(action)

    将 action dispatch 给 reducer;

1.  subscribe(listener)

    监听 store 变化

### action

描述一个行为

```js
{
  type: ADD_TODO, // 类型
  text: '看书',
}
```

### reducer

处理真正的数据, 更新 state;

```js
function todoApp(state = initialState, action) {
  switch (action.type) {
    case ADD_TODO:
      return Object.assign({}, state, {
        todos: [
          // ...
        ],
      });
    default:
      return state;
  }
}
```

一个 action dispatch 出去后, 所有的 reducer 都能收到; 通过 action.type 来判断是否需要自己(reducer)执行;

### combineReducers

组合多个 reducer;

```js
import { combineReducers  } from 'redux';

const visibilityReducer = createReducer('SHOW_ALL', {
    'SET_VISIBILITY_FILTER' : setVisibilityFilter
});

// Case reducer
function editTodo(todosState, action) {
    const newTodos = updateItemInArray(todosState, action.id, todo => {
        return updateObject(todo, {text : action.text});
    });
​
    return newTodos;
}

// Slice reducer
const todosReducer = createReducer([], {
    'ADD_TODO' : addTodo,
    'TOGGLE_TODO' : toggleTodo,
    'EDIT_TODO' : editTodo
});
​
// "Root reducer"
const appReducer = combineReducers({
    visibilityFilter : visibilityReducer,
    todos : todosReducer
});
```

### bindActionCreators

更方便的使用 action

```js
export function addTodo(text) {
  return {
    type: 'ADD_TODO',
    text
  }
}
​
dispatch(addTodo(text));

const addTodoBind = bindActionCreators(addTodo, dispatch)
addTodoBind(text); // 使用的时候, 不要需要知道 dispatch 在哪, 直接使用就好了
```
