open ReactNative;

[@react.component]
let make = (~style as s=?, ~children) => {
  <View style=Style.(arrayOption([|Some(Predefined.styles##col), s|]))>
    children
  </View>;
};

module Center = {
  [@react.component]
  let make = (~style as s=?, ~children) => {
    <View
      style=Style.(arrayOption([|Some(Predefined.styles##colCenter), s|]))>
      children
    </View>;
  };
};

module SpaceBetween = {
  [@react.component]
  let make = (~style as s=?, ~children) => {
    <View
      style=Style.(
        arrayOption([|Some(Predefined.styles##colSpaceBetween), s|])
      )>
      children
    </View>;
  };
};
