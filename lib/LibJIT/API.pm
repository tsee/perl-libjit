package LibJIT::API;

use strict;
use warnings;

use LibJIT;

use Exporter 'import';

my @Functions = qw(
    jit_context_create
    jit_context_build_start
    jit_context_build_end
    jit_context_destroy

    jit_function_create
    jit_function_compile
    jit_function_to_closure
    jit_function_apply
    jit_function_get_context
    jit_function_is_compiled
    jit_function_set_recompilable
    jit_function_clear_recompilable
    jit_function_is_recompilable
    jit_function_set_optimization_level
    jit_function_get_optimization_level
    jit_function_get_max_optimization_level

    jit_insn_new_block
    jit_insn_load
    jit_insn_add
    jit_insn_dup
    jit_insn_mul
    jit_insn_return
    jit_insn_store

    jit_type_create_signature

    jit_value_create
    jit_value_create_nint_constant
    jit_value_create_float64_constant
    jit_value_get_param
);

my @Constants = qw(
    jit_abi_cdecl
    jit_abi_vararg
    jit_abi_stdcall
    jit_abi_fastcall

    jit_type_int
    jit_type_nint
    jit_type_float64
    jit_type_void_ptr
);

our @EXPORT_OK = (@Functions, @Constants);
our %EXPORT_TAGS = (
    all       => \@EXPORT_OK,
    functions => \@Functions,
    constants => \@Constants,
);

1;
