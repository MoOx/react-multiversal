open Belt
open ReactNative

module NativeBlurView = {
  @react.component @module("@react-native-community/blur")
  external make: (
    ~blurType: [
      | #xlight
      | #light
      | #dark
      | #extraDark
      | #regular
      | #prominent
    ]=?,
    ~blurAmount: int=?,
    ~style: ReactNative.Style.t=?,
    ~children: React.element=?,
  ) => React.element = "BlurView"
}

module WebBlurView = {
  @module("react-native")
  external unstable_createElement: (
    string,
    {"style": option<ReactNative.Style.t>},
    option<React.element>,
  ) => React.element = "unstable_createElement"

  @react.component
  let make = (~backdropFilter=?, ~style as s=?, ~children=?) =>
    unstable_createElement(
      "div",
      {
        "style": Some({
          open Style
          arrayOption([
            s,
            backdropFilter->Option.map(f =>
              unsafeStyle({
                "webkitBackdropFilter": f,
                "backdropFilter": f,
              })
            ),
          ])
        }),
      },
      children,
    )
}

let webLight = "saturate(200%) brightness(150%) grayscale(20%) blur(20px)"

@react.component
let make = (
  ~nativeBlurType as blurType=?,
  ~nativeBlurAmount as blurAmount=?,
  ~webBackdropFilter as backdropFilter=?,
  ~style=?,
  ~children=?,
) => {
  let child = children->Option.getWithDefault(React.null)
  switch Platform.os {
  | os if os == Platform.ios || os == Platform.android =>
    <NativeBlurView ?blurType ?blurAmount ?style> child </NativeBlurView>
  | os if os == Platform.web => <WebBlurView ?backdropFilter ?style> child </WebBlurView>
  | _ => <View ?style> child </View>
  }
}
