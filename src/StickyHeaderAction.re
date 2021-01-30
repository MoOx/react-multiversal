open ReactNative;

type iconPosition = [ | `left | `right];

let hitSlop =
  View.edgeInsets(~top=10., ~left=10., ~bottom=10., ~right=10., ());

[@react.component]
let make = (~color="#000", ~onPress, ~children) => {
  <TouchableOpacity onPress={_ => onPress()} hitSlop>
    <Row.Center>
      <Animated.Text allowFontScaling=false style=Style.(style(~color, ()))>
        ...children
      </Animated.Text>
    </Row.Center>
  </TouchableOpacity>;
};
