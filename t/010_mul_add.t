#!/usr/bin/env perl

use strict;
use warnings;

use Test::More tests => 8;

use LibJIT::API qw(:all);

my $cxt = jit_context_create();

jit_context_build_start($cxt);

my $signature = jit_type_create_signature(
    jit_abi_cdecl, jit_type_int,
    [jit_type_int, jit_type_int, jit_type_int], 1);
my $fun = jit_function_create($cxt, $signature);

# Just add arbitrary test for jit_function_* aux functions
isa_ok(jit_function_get_context($fun), 'LibJIT::Context');

ok(!jit_function_is_compiled($fun), "jit_function_is_compiled on uncompiled function");
jit_function_set_recompilable($fun);
ok(jit_function_is_recompilable($fun), "jit_function_is_recompilable on recomp. function");
jit_function_clear_recompilable($fun);
ok(!jit_function_is_recompilable($fun), "jit_function_is_recompilable on non-recomp. function");

ok(defined(jit_function_get_max_optimization_level()), "jit_function_get_max_optimization_level");
jit_function_set_optimization_level($fun, jit_function_get_max_optimization_level());
ok(defined(jit_function_get_optimization_level($fun)), "jit_function_get_optimization_level");


# emit code
my ($x, $y, $z) = map jit_value_get_param($fun, $_), 0..2;
my $t1 = jit_insn_mul($fun, $x, $y);
my $t2 = jit_insn_add($fun, $t1, $z);
jit_insn_return($fun, $t2);

jit_function_compile($fun);
jit_context_build_end($cxt);

my $r1 = jit_function_apply($fun, 3, 5, 2);
is($r1, 17);

my $r2 = jit_function_apply($fun, 5, 8, 2);
is($r2, 42);

jit_context_destroy($cxt);
