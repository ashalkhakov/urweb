fun main () : transaction page =
    n <- source 0;
    return <xml><body>
      <button onclick={fn _ => n' <- get n; set n (n' + 1); debug ("Message: " ^ show n')}>click me</button>
    </body></xml>
