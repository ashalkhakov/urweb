functor Make(M : sig
                 con ts :: {(Type * Type)}
                 val tab : sql_table (map fst ts) []
                 val cols : $(map (fn p => p.2 -> string) ts)
             end) = struct
end

table t : {A : string}

open Make(struct
              val tab = t
              val cols = {A = fn p : {B : string, C : string} => p.B ^ p.C}
          end)

task initialize = fn () =>
                     dml (DELETE FROM t WHERE 1=1);
                     dml (INSERT INTO t (A) VALUES ('hello'));
                     dml (INSERT INTO t (A) VALUES ('world'))

fun main (): transaction page =
    r <- queryX1 (SELECT * FROM t) (fn r => <xml><p>{[r.A]}</p></xml>);
    return <xml>
      <body>
        {r}
      </body>
    </xml>
