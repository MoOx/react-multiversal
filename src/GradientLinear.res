open Belt
open ReactNativeSvg
module RNS = ReactNative.Style

type stop = {
  offset: size,
  stopColor: string,
  stopOpacity: string,
}

let transparentToBlack = [
  {
    offset: 0.->RNS.pct,
    stopColor: "#000",
    stopOpacity: "0",
  },
  {
    offset: 100.->RNS.pct,
    stopColor: "#000",
    stopOpacity: "1",
  },
]

@react.component
let make = (~width: size, ~height: size, ~stops: array<stop>) => {
  let id =
    stops
    ->Array.map(stop => {
      "o:" ++ stop.offset->Obj.magic ++ "c:" ++ stop.stopColor ++ "o:" ++ stop.stopOpacity
    })
    ->Array.joinWith("::", s => s)

  <Svg width height>
    <Defs>
      <LinearGradient id x1={0.->RNS.dp} y1={0.->RNS.dp} x2={0.->RNS.dp} y2=height>
        {stops
        ->Array.map(stop =>
          <Stop
            key={stop.offset->Obj.magic ++ (stop.stopColor ++ stop.stopOpacity)}
            offset=stop.offset
            stopColor=stop.stopColor
            stopOpacity=stop.stopOpacity
          />
        )
        ->React.array}
      </LinearGradient>
    </Defs>
    <Rect x={0.->RNS.dp} y={0.->RNS.dp} width height fill={"url(#" ++ id ++ ")"} />
  </Svg>
}
