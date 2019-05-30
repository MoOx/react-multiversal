open ReactNative;

let isClient: bool = [%bs.raw "typeof window !== \"undefined\""];

// https://github.com/necolas/react-native-web/pull/1351
let hairlineWidth =
  isClient
    ? {
      let hairlineWidth = PixelRatio.roundToNearestPixel(0.4);
      if (hairlineWidth === 0.) {
        1. /. PixelRatio.get();
      } else {
        hairlineWidth;
      };
    }
    // don't use 1 because I guess most people have retina
    // at least the scope I have...
    // @todo allow to config that
    : 0.5;
// beside this, some browser round to 0 something like 0.3333333333, instead of 0.34...)
let hairlineWidthMaxPrecision = 6.;
let hairlineWidth =
  Js.Math.round(hairlineWidth *. 10. ** hairlineWidthMaxPrecision)
  /. 10.
  ** hairlineWidthMaxPrecision;

// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/typography/
// module Fonts = {
//   open Style;
//   Style	Weight	Size (Points)	Leading (Points)	Tracking (1/1000em)
//   Large Title	Regular	34	41	+11
//   Title 1	Regular	28	34	+13
//   Title 2	Regular	22	28	+16
//   Title 3	Regular	20	25	+19
//   Headline	Semi-Bold	17	22	-24
//   Body	Regular	17	22	-24
//   Callout	Regular	16	21	-20
//   Subhead	Regular	15	20	-16
//   Footnote	Regular	13	18	-6
//   Caption 1	Regular	12	16	0
//   Caption 2	Regular	11	13	+6
// };

// https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/
module Colors = {
  let black = "#000";
  let dark = "rgb(51, 51, 51)";
  let white = "#fff";
  let grey = "#909192";
  // let grey2 = "rgb(89, 89, 89)";
  // let grey3 = "rgb(102, 102, 102)";
  let lightGrey = "rgb(242, 242, 242)";
  // let lightGrey2 = "#DADADA";
  let red = "rgb(255, 59, 48)";
  let orange = "rgb(255, 149, 0)";
  let yellow = "rgb(255, 204, 0)";
  let green = "rgb(76, 217, 100)";
  let tealBlue = "rgb(90, 200, 250)";
  let blue = "rgb(0, 122, 255)";
  let purple = "rgb(88, 86, 214)";
  let pink = "rgb(255, 45, 85)";
  let separator = "#A2A9AC";
};

let styles =
  Style.(
    StyleSheet.create({
      "flex": style(~flex=1., ()),
      "flexGrow": style(~flexGrow=1., ()),
      "flexShrink": style(~flexShrink=1., ()),
      "center": style(~alignItems=`center, ~justifyContent=`center, ()),
      "col": style(~flexDirection=`column, ()),
      "colCenter":
        style(
          ~flexDirection=`column,
          ~justifyContent=`center,
          ~alignItems=`center,
          (),
        ),
      "colSpaceBetween":
        style(
          ~flexDirection=`column,
          ~justifyContent=`spaceBetween,
          ~alignItems=`center,
          (),
        ),
      "row": style(~flexDirection=`row, ()),
      "rowCenter":
        style(
          ~flexDirection=`row,
          ~justifyContent=`center,
          ~alignItems=`center,
          (),
        ),
      "rowSpaceBetween":
        style(
          ~flexDirection=`row,
          ~justifyContent=`spaceBetween,
          ~alignItems=`center,
          (),
        ),
      "rowWrap": style(~flexDirection=`row, ~flexWrap=`wrap, ()),
      "rowWrapCenter":
        style(
          ~flexDirection=`row,
          ~flexWrap=`wrap,
          ~justifyContent=`center,
          ~alignItems=`center,
          (),
        ),
      "rowWrapSpaceBetween":
        style(
          ~flexDirection=`row,
          ~flexWrap=`wrap,
          ~justifyContent=`spaceBetween,
          ~alignItems=`center,
          (),
        ),
    })
  );
