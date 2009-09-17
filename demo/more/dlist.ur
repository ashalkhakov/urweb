datatype dlist'' t =
         Nil
       | Cons of t * source (dlist'' t)

datatype dlist' t =
         Empty
       | Nonempty of { Head : dlist'' t, Tail : source (source (dlist'' t)) }

con dlist t = source (dlist' t)

type position = transaction unit

fun headPos [t] (dl : dlist t) =
    dl' <- get dl;
    case dl' of
        Nonempty { Head = Cons (_, tl), Tail = tl' } =>
        cur <- get tl;
        set dl (case cur of
                    Nil => Empty
                  | _ => Nonempty {Head = cur, Tail = tl'})
      | _ => return ()

fun tailPos [t] (cur : source (dlist'' t)) new tail =
    new' <- get new;
    set cur new';

    case new' of
        Nil => set tail cur
      | _ => return ()

val create [t] = source Empty

fun clear [t] (s : dlist t) = set s Empty

fun append [t] dl v =
    dl' <- get dl;
    case dl' of
        Empty =>
        tl <- source Nil;
        tl' <- source tl;
        set dl (Nonempty {Head = Cons (v, tl), Tail = tl'});
        return (headPos dl)
                
      | Nonempty {Tail = tl, ...} =>
        cur <- get tl;
        new <- source Nil;
        set cur (Cons (v, new));
        set tl new;
        return (tailPos cur new tl)

fun renderDyn [ctx] [ctx ~ body] [t] (f : t -> position -> xml (ctx ++ body) [] []) filter dl = <xml>
  <dyn signal={dl' <- signal dl;
               return (case dl' of
                           Empty => <xml/>
                         | Nonempty {Head = hd, Tail = tlTop} => 
                           let
                               fun render' prev dl'' =
                                   case dl'' of
                                       Nil => <xml/>
                                     | Cons (v, tl) =>
                                       let
                                           val pos = case prev of
                                                         None => headPos dl
                                                       | Some prev => tailPos prev tl tlTop
                                       in
                                           <xml><dyn signal={b <- filter v;
                                                             return (if b then
                                                                         f v pos
                                                                     else
                                                                         <xml/>)}/>
                                             <dyn signal={tl' <- signal tl;
                                                          return (render' (Some tl) tl')}/></xml>
                                       end
                           in
                               render' None hd
                           end)}/>
</xml>

fun renderFlat [ctx] [ctx ~ body] [t] (f : t -> position -> xml (ctx ++ body) [] []) filter ls =
    List.mapX (fn p => f p.1 p.2) ls

val split [t] =
    let
        fun split' acc (ls : list t) =
            case ls of
                [] => acc
              | x1 :: [] => (x1 :: acc.1, acc.2)
              | x1 :: x2 :: ls => split' (x1 :: acc.1, x2 :: acc.2) ls
    in
        split' ([], [])
    end

fun merge [t] (cmp : t -> t -> signal bool) =
    let
        fun merge' acc (ls1 : list t) (ls2 : list t) =
            case (ls1, ls2) of
                ([], _) => return (List.revAppend acc ls2)
              | (_, []) => return (List.revAppend acc ls1)
              | (x1 :: ls1', x2 :: ls2') =>
                b <- cmp x1 x2;
                if b then
                    merge' (x1 :: acc) ls1' ls2
                else
                    merge' (x2 :: acc) ls1 ls2'
    in
        merge' []
    end

fun sort [t] (cmp : t -> t -> signal bool) =
    let
        fun sort' (ls : list t) =
            case ls of
                [] => return ls
              | _ :: [] => return ls
              | _ =>
                let
                    val (ls1, ls2) = split ls
                in
                    ls1' <- sort' ls1;
                    ls2' <- sort' ls2;
                    merge cmp ls1' ls2'
                end
    in
        sort'
    end

fun render [ctx] [ctx ~ body] [t] f (r : {Filter : t -> signal bool,
                                          Sort : signal (option (t -> t -> signal bool))}) dl = <xml>
    <dyn signal={cmp <- r.Sort;
                 case cmp of
                     None => return (renderDyn f r.Filter dl)
                   | Some cmp =>
                     dl' <- signal dl;
                     elems <- (case dl' of
                                   Empty => return []
                                 | Nonempty {Head = hd, Tail = tlTop} =>
                                   let
                                       fun listOut prev dl'' acc =
                                           case dl'' of
                                               Nil => return acc
                                             | Cons (v, tl) =>
                                               let
                                                   val pos = case prev of
                                                                 None => headPos dl
                                                               | Some prev => tailPos prev tl tlTop
                                               in
                                                   tl' <- signal tl;
                                                   listOut (Some tl) tl' ((v, pos) :: acc)
                                               end
                                   in
                                       listOut None hd []
                                   end);
                     elems <- sort (fn v1 v2 => cmp v1.1 v2.1) elems;
                     return (renderFlat f r.Filter elems)}/>
</xml>
                             
        

fun delete pos = pos

fun elements' [t] (dl'' : dlist'' t) =
    case dl'' of
        Nil => return []
      | Cons (x, dl'') =>
        dl'' <- signal dl'';
        tl <- elements' dl'';
        return (x :: tl)

fun elements [t] (dl : dlist t) =
    dl' <- signal dl;
    case dl' of
        Empty => return []
      | Nonempty {Head = hd, ...} => elements' hd

fun foldl [t] [acc] (f : t -> acc -> signal acc) =
    let
        fun foldl'' (i : acc) (dl : dlist'' t) : signal acc =
            case dl of
                Nil => return i
              | Cons (v, dl') =>
                dl' <- signal dl';
                i' <- f v i;
                foldl'' i' dl'

        fun foldl' (i : acc) (dl : dlist t) : signal acc =
            dl <- signal dl;
            case dl of
                Empty => return i
              | Nonempty {Head = dl, ...} => foldl'' i dl
    in
        foldl'
    end
