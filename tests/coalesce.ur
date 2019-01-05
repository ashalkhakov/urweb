table t : { A : option int }

task initialize = fn () =>
    dml (DELETE FROM t WHERE 1 = 1);
    dml (INSERT INTO t (A) VALUES (NULL));
    dml (INSERT INTO t (A) VALUES ({[Some 1]}))

fun main () : transaction page =
    queryX (SELECT COALESCE(t.A, 13)
            FROM t)
    (fn r => <xml>{[r.1]},</xml>)
