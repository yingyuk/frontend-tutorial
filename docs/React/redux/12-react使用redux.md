react 中使用 redux

```js
import { connect } from 'react-redux';

class Link extends React.Component {
  // ...
}

const mapStateToProps = (state, ownProps) => {
  return {
    // 如果把整个 state 绑定上来, 那么 state 的任何变化, 都会触发整个组件的更新
    // 所以不应该把整个 state 绑定上来, 而是需要用什么就绑定什么
    active: ownProps.filter === state.visibilityFilter,
  };
};

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    onClick: () => {
      dispatch(setVisibilityFilter(ownProps.filter));
    },
    actions: bindActionCreators({ ...actions }, dispatch),
  };
};

// 高阶组件
const FilterLink = connect(
  mapStateToProps,
  mapDispatchToProps
)(Link);

export default class LinkSample extends React.Component {
  render() {
    return (
      // 只需要根节点提供 store
      <Provider store={store}>
        <FilterLink />
      </Provider>
    );
  }
}
```

connect 的原理其实就是高阶组件
