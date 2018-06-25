### 异步 action

以 ajax 请求为例;

view 被点击 -> 派发 action -> 中间件截获(发起接口请求) -> 派发真正的 action 给 reducer -> reducer 处理数据

```js
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';

const store = createStore(rootReducer, applyMiddleware(thunk));

export function fetchList(args = {}) {
  return dispatch => {
    dispatch({
      type: FETCH_BEGIN,
    });
    return fetch('https://www.google.com/search?q=secret+sauce').then(
      res => {
        dispatch({
          type: FETCH_SUCCESS,
          data: res.data,
        });
      },
      err => {
        dispatch({
          type: FETCH_FAILURE,
          data: { error: err },
        });
      }
    );
  };
}
```

### Redux 中间件

1.  截获 action

    判断 action 是否是一个函数, 或者 promise

1.  发出 action

### 小结

1.  异步 action 不是特殊 action;

    是多个同步 action 的组合使用

1.  中间件在 dispatcher 中截获做特殊处理
