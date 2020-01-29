/* BLOCK COMMENT
var dont_capture_me;
*/
// const a /* ANOTHER BLOCK COMMENT */, b;

export {
  exp01,
  orig_name_exp_02 as exp02
};

export {exp03};

export const { exp04, exp05 } = { do_not_parse_me };

export const { exp06, exp07 = "de\"f_val07" } = not_exported1;

export const { exp08 = 'def_ \'val08', exp09} = { not_exported2 };

export const { exp10, exp11 = default_var11, exp12 } = processSomething(
  foo(a, b),
  bar(a, c),
  fux(c, d),
);

export { exp13, not_exported3 as exp14 } from 'some-package/foo/bar';
