fun main () =
  case #"A" of
      #"B" => return <xml/>
    | _ => return <xml><body>A!</body></xml>
