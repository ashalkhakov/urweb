fun main () =
    s <- source "DEFAULT";
    return <xml><body>
      <ctextarea rows={2} source={s}/><br/>
      <br/>
      <p>
        <dyn signal={s <- signal s; return (cdata s)}/>
      </p>
    </body></xml>
