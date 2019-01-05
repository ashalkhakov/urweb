functor F(M : sig
              table t : { A : int, B : int }
                PRIMARY KEY A
          end) = struct
    open M

    fun getByA a = oneRow1 (SELECT * FROM t WHERE t.A = {[a]})
end

table u : { A : int, B : int }
  PRIMARY KEY A,
  CONSTRAINT B UNIQUE B

open F(struct
           val t = u
       end)

task initialize = fn () =>
                     dml (DELETE FROM u WHERE 1 = 1);
                     dml (INSERT INTO u (A, B) VALUES (1, 2));
                     dml (INSERT INTO u (A, B) VALUES (2, 3));
                     dml (INSERT INTO u (A, B) VALUES (3, 5))

fun fails (): transaction page =
    a0 <- getByA 0;
    return <xml><body>wow</body></xml>

fun main (): transaction page =
    a1 <- getByA 1;
    a2 <- getByA 3;
    return <xml><body>
      <div>{[a1.A]} {[a1.B]}</div>
      <div>{[a2.A]} {[a2.B]}</div>
    </body></xml>
