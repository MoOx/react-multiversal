[@react.component]
let make =
    (
      ~width,
      ~height,
      ~color1="rgb(0,0,0)",
      ~opacity1="0",
      ~color2="rgb(0,0,0)",
      ~opacity2="1",
    ) =>
  <svg width height>
    <defs>
      <linearGradient id="grad" x1="0" y1="0" x2="0" y2=height>
        <stop offset="0%" stopColor=color1 stopOpacity=opacity1 />
        <stop offset="100%" stopColor=color2 stopOpacity=opacity2 />
      </linearGradient>
    </defs>
    <rect x="0" y="0" width height fill="url(#grad)" />
  </svg>;
