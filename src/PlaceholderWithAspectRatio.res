open ReactNative

@react.component
let make = (~ratio, ~children=?, ()) =>
  <View
    pointerEvents=#"box-none"
    style={
      open Style
      style(~width=100.->pct, ~paddingBottom=(100. *. ratio)->pct, ())
    }>
    {children->Belt.Option.getWithDefault(React.null)}
  </View>
