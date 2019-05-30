open ReactNative;

[@react.component]
let make = (~style as s=?, ~children) => {
  <View style=Style.(arrayOption([|Some(Predefined.styles##center), s|]))>
    ...children
  </View>;
};
