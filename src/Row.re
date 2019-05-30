open ReactNative;

[@react.component]
let make = (~style as s=?, ~children) => {
  <View style=Style.(arrayOption([|Some(Predefined.styles##row), s|]))>
    children
  </View>;
};

module Center = {
  [@react.component]
  let make = (~style as s=?, ~children) => {
    <View
      style=Style.(arrayOption([|Some(Predefined.styles##rowCenter), s|]))>
      children
    </View>;
  };
};

module SpaceBetween = {
  [@react.component]
  let make = (~style as s=?, ~children) => {
    <View
      style=Style.(
        arrayOption([|Some(Predefined.styles##rowSpaceBetween), s|])
      )>
      children
    </View>;
  };
};

module Wrap = {
  [@react.component]
  let make = (~style as s=?, ~children) => {
    <View style=Style.(arrayOption([|Some(Predefined.styles##rowWrap), s|]))>
      children
    </View>;
  };

  module Center = {
    [@react.component]
    let make = (~style as s=?, ~children) => {
      <View
        style=Style.(
          arrayOption([|Some(Predefined.styles##rowWrapCenter), s|])
        )>
        children
      </View>;
    };
  };

  module SpaceBetween = {
    [@react.component]
    let make = (~style as s=?, ~children) => {
      <View
        style=Style.(
          arrayOption([|Some(Predefined.styles##rowWrapSpaceBetween), s|])
        )>
        children
      </View>;
    };
  };
};
