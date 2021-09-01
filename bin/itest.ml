open Gg
open Vg
open P2

let simple_cut ?(c = Color.black) p =
  I.cut ~area:(`O { P.o with P.width = 0.01 }) p (I.const c)

let simple_filled_cut ?(area = `Anz) ?(c = Color.black) p =
  I.cut ~area p (I.const c)

let filled_with_border ?(area = `Anz) ?(c = Color.black) p =
  p |> simple_filled_cut ~area ~c |> I.blend (simple_cut p)

(* PASS. *)
let two_stroked_straight_lines =
  P.empty
  |> P.sub (v 0.2 0.)
  |> P.line (v 0.5 0.25)
  |> P.line (v 0.25 0.5)
  |> simple_cut

(* PASS. *)
let three_stroked_straight_lines =
  P.empty
  |> P.sub (v 0.2 0.)
  |> P.line (v 0.5 0.25)
  |> P.line (v 0.25 0.5)
  |> P.line (v (-0.25) 0.3)
  |> simple_cut

(* PASS. *)
let two_stroked_sub_lines =
  P.empty
  |> P.sub (v 0.2 0.)
  |> P.line (v 0.5 0.25)
  |> P.sub (v 0.25 0.5)
  |> P.line (v (-0.25) 0.3)
  |> simple_cut

(* PASS. *)
let closed_sub_paths =
  P.empty
  |> P.sub (v 0.2 0.)
  |> P.line (v 0.5 0.25)
  |> P.sub (v 0.5 0.5)
  |> P.line (v 0.6 0.5)
  |> P.line (v 0.6 0.6)
  |> P.close
  |> simple_cut

(* PASS. *)
let issue_12 =
  P.empty
  |> P.rect (Box2.v (v 0.25 0.25) (v 0.75 0.75))
  |> simple_cut ~c:(Color.v 0.2 0.2 0.8 1.)

(* PASS. *)
let simple_stroked_square =
  P.empty
  |> P.rect (Box2.v (v 0.25 0.25) (v 0.5 0.5))
  |> simple_cut ~c:(Color.v 0.2 0.2 0.8 1.)

(* PASS. *)
let imbricated_stroked_squares =
  P.empty
  |> P.rect (Box2.v (v 0.25 0.25) (v 0.5 0.5))
  |> P.rect (Box2.v (v 0.3 0.3) (v 0.4 0.4))
  |> filled_with_border ~area:`Anz ~c:(Color.v 0.2 0.2 0.8 1.)

(* PASS. *)
let simple_filled_rect =
  P.empty
  |> P.rect (Box2.v (v 0.25 0.25) (v 0.5 0.5))
  |> simple_filled_cut ~area:`Aeo ~c:(Color.v 0.88 0.69 1. 1.)

(* PASS. *)
let imbricated_filled_squares_same_dir =
  P.empty
  |> P.rect (Box2.v (v 0.25 0.25) (v 0.5 0.5))
  |> P.rect (Box2.v (v 0.3 0.3) (v 0.4 0.4))
  |> filled_with_border ~area:`Anz ~c:(Color.v 0.88 0.69 1. 1.)

(* PASS. *)
let imbricated_filled_squares_not_same_dir =
  P.empty
  |> P.rect (Box2.v (v 0.25 0.25) (v 0.5 0.5))
  |> P.sub (v 0.3 0.3)
  |> P.line (v 0.3 0.7)
  |> P.line (v 0.7 0.7)
  |> P.line (v 0.7 0.3)
  |> P.close
  |> filled_with_border ~area:`Anz ~c:(Color.v 0.88 0.69 1. 1.)

(** PASS. *)
let basic_cbezier =
  P.empty |> P.ccurve (v 0.8 0.2) (v 0.2 0.8) (v 0.5 0.5) |> simple_cut

(** PASS. *)
let closed_cbezier =
  P.empty
  |> P.ccurve (v 0.8 0.2) (v 0.8 0.2) (v 0.5 0.5)
  |> P.close
  |> simple_cut

(** PASS. *)
let filled_cbezier =
  P.empty
  |> P.ccurve (v 0.8 0.2) (v 0.8 0.2) (v 0.5 0.5)
  |> P.close
  |> simple_filled_cut ~area:`Aeo ~c:(Color.v 0.48 0.71 0.38 1.)

(** PASS. *)
let mult_filled_cbeziers =
  P.empty
  |> P.ccurve (v 0.8 0.2) (v 0.8 0.2) (v 0.5 0.5)
  |> P.ccurve (v 0.8 0.2) (v 0.8 0.2) (v 0.6 0.3)
  |> P.close
  |> simple_filled_cut ~area:`Aeo ~c:(Color.v 0.48 0.71 0.38 1.)

(** PASS. *)
let mult_filled_cbeziers_bug =
  P.empty
  |> P.ccurve (v 0.8 0.2) (v 0.8 0.2) (v 0.5 0.5)
  |> P.ccurve (v 0.8 0.2) (v 0.8 0.2) (v 0.8 0.2)
  |> P.close
  |> simple_filled_cut ~area:`Aeo ~c:(Color.v 0.48 0.71 0.38 1.)

(** PASS. *)
let simple_qbezier =
  P.empty |> P.qcurve (v 0.8 0.2) (v 0.5 0.5) |> P.close |> simple_cut

(** PASS. *)
let filled_qbezier =
  P.empty
  |> P.qcurve (v 0.6 0.2) (v 0.5 0.5)
  |> P.close
  |> simple_filled_cut ~c:(Color.v 0.48 0.71 0.38 1.)

(** PASS. *)
let mult_filled_qbeziers =
  P.empty
  |> P.qcurve (v 0.8 0.2) (v 0.5 0.5)
  |> P.qcurve (v 0.8 0.2) (v 0.6 0.3)
  |> P.close
  |> simple_filled_cut ~area:`Aeo ~c:(Color.v 0.48 0.71 0.38 1.)

(** PASS. *)
let triangle =
  P.empty
  |> P.sub (v 0.2 0.2)
  |> P.line (v 0.6 0.2)
  |> P.line (v 0.4 0.8)
  |> P.close
  |> simple_filled_cut ~area:`Anz ~c:(Color.v 0.48 0.71 0.38 1.)

(** PASS. *)
let poly1 =
  P.empty
  |> P.sub (v 0.2 0.2)
  |> P.line (v 0.2 0.6)
  |> P.line (v 0.3 0.4)
  |> P.line (v 0.5 0.6)
  |> P.line (v 0.8 0.2)
  |> P.close
  |> filled_with_border ~area:`Aeo ~c:(Color.v 0.48 0.71 0.38 1.)

(** PASS. *)
let star =
  P.empty
  |> P.sub (v 0.2 0.1)
  |> P.line (v 0.3 0.7)
  |> P.line (v 0.4 0.1)
  |> P.line (v 0.1 0.5)
  |> P.line (v 0.5 0.5)
  |> P.close
  |> filled_with_border ~area:`Anz ~c:(Color.v 0.48 0.71 0.38 1.)

(** PASS. *)
let scale_poly = I.scale (v 0.5 0.5) poly1

(** PASS. *)
let move_poly = I.move (v 0.25 0.25) scale_poly

(** PASS. *)
let rot_poly = I.rot 0.20 move_poly

(** PASS. *)
let m_poly = I.tr M3.(v 0.5 0. 0.3 0. 1. 0. 0. 0. 1.) scale_poly

(** PASS. *)
let m_poly2 = I.tr M3.(v 0.5 0. 0.3 0. 1. 0. 0. 0. 1.) rot_poly
