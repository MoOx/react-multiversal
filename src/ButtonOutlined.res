open ReactNative

let styles = {
  open Style
  {
    "container": style(
      ~borderRadius=6.,
      ~justifyContent=#center,
      ~alignItems=#center,
      ~borderWidth=1.,
      (),
    ),
    "rounded": style(~borderRadius=100., ()),
    "row": style(~flexDirection=#row, ~alignItems=#center, ()),
  }
}->StyleSheet.create

@react.component
let make = (
  ~accessibilityLabel=?,
  ~round=false,
  ~color as c1="black",
  ~horizontalSpace as horizontal: SpacedView.size=M,
  ~verticalSpace as vertical: SpacedView.size=S,
  ~style as s=?,
  ~children,
  _,
) =>
  <View
    ?accessibilityLabel
    style={
      open Style
      arrayOption([
        Some(array([styles["container"], style(~backgroundColor=c1, ~borderColor=c1, ())])),
        round ? Some(styles["rounded"]) : None,
        s,
      ])
    }>
    <SpacedView horizontal vertical style={styles["row"]}> children </SpacedView>
  </View>

module Text = {
  @react.component
  let make = (~textSize=16., ~style as s=?, ~color as c2="white", ~children) =>
    <Text
      style={
        open Style
        arrayOption([
          Some(style(~fontSize=textSize, ~lineHeight=textSize, ~fontWeight=#_600, ~color=c2, ())),
          s,
        ])
      }>
      children
    </Text>
}
