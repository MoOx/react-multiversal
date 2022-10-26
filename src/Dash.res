open Belt
open ReactNative

@react.component
let make = React.memo((
  ~style as styl=?,
  ~rowStyle=#column,
  ~length,
  ~dashGap=3.,
  ~dashLength=3.,
  ~dashThickness=StyleSheet.hairlineWidth,
  ~dashColor,
) => {
  let isRow = switch rowStyle {
  | #row => true
  | #"row-reverse" => true
  | #column => false
  | #"column-reverse" => false
  }

  let n = ceil(length /. (dashGap +. dashLength))->int_of_float

  <View
    style={
      open Style
      arrayOption([styl, Some(viewStyle(~flexDirection=rowStyle, ()))])
    }>
    {Array.range(0, n - 1)
    ->Array.map(i =>
      <View
        key={i->string_of_int}
        style={
          open Style
          style(
            ~width=(isRow ? dashLength : dashThickness)->dp,
            ~height=(isRow ? dashThickness : dashLength)->dp,
            ~marginRight=(isRow ? dashGap : 0.)->dp,
            ~marginBottom=(isRow ? 0. : dashGap)->dp,
            ~backgroundColor=dashColor,
            (),
          )
        }
      />
    )
    ->React.array}
  </View>
})
