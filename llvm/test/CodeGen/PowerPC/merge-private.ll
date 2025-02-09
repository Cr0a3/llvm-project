; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -verify-machineinstrs -mtriple powerpc64-ibm-aix-xcoff -mcpu=pwr8 \
; RUN:     -ppc-asm-full-reg-names < %s | FileCheck %s \
; RUN:     --check-prefix=AIX64
; RUN: llc -verify-machineinstrs -mtriple powerpc-ibm-aix-xcoff -mcpu=pwr8 \
; RUN:     -ppc-asm-full-reg-names < %s | FileCheck %s \
; RUN:     --check-prefix=AIX32
; RUN: llc -verify-machineinstrs -mtriple powerpc64le-unknown-linux -mcpu=pwr8 \
; RUN:     -ppc-asm-full-reg-names -ppc-global-merge=true < %s | FileCheck %s \
; RUN:     --check-prefix=LINUX64LE
; RUN: llc -verify-machineinstrs -mtriple powerpc64-unknown-linux -mcpu=pwr8 \
; RUN:     -ppc-asm-full-reg-names -ppc-global-merge=true < %s | FileCheck %s \
; RUN:     --check-prefix=LINUX64BE
; The below run line is added to ensure that the assembly corresponding to
; the following check-prefix is generated by default on AIX (without any
; options).
; RUN: llc -verify-machineinstrs -mtriple powerpc64-ibm-aix-xcoff -mcpu=pwr8 \
; RUN:     -ppc-asm-full-reg-names < %s | FileCheck %s \
; RUN:     --check-prefix=AIX64

@.str = private unnamed_addr constant [15 x i8] c"Private global\00", align 1
@str = internal constant [16 x i8] c"Internal global\00", align 1

declare noundef signext i32 @puts(ptr nocapture noundef readonly)

define dso_local void @print_func() {
; AIX64-LABEL: print_func:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    mflr r0
; AIX64-NEXT:    stdu r1, -128(r1)
; AIX64-NEXT:    std r0, 144(r1)
; AIX64-NEXT:    std r31, 120(r1) # 8-byte Folded Spill
; AIX64-NEXT:    ld r31, L..C0(r2) # @_MergedGlobals
; AIX64-NEXT:    mr r3, r31
; AIX64-NEXT:    bl .puts[PR]
; AIX64-NEXT:    nop
; AIX64-NEXT:    addi r3, r31, 15
; AIX64-NEXT:    bl .puts[PR]
; AIX64-NEXT:    nop
; AIX64-NEXT:    ld r31, 120(r1) # 8-byte Folded Reload
; AIX64-NEXT:    addi r1, r1, 128
; AIX64-NEXT:    ld r0, 16(r1)
; AIX64-NEXT:    mtlr r0
; AIX64-NEXT:    blr
;
; AIX32-LABEL: print_func:
; AIX32:       # %bb.0: # %entry
; AIX32-NEXT:    mflr r0
; AIX32-NEXT:    stwu r1, -64(r1)
; AIX32-NEXT:    stw r0, 72(r1)
; AIX32-NEXT:    stw r31, 60(r1) # 4-byte Folded Spill
; AIX32-NEXT:    lwz r31, L..C0(r2) # @_MergedGlobals
; AIX32-NEXT:    mr r3, r31
; AIX32-NEXT:    bl .puts[PR]
; AIX32-NEXT:    nop
; AIX32-NEXT:    addi r3, r31, 15
; AIX32-NEXT:    bl .puts[PR]
; AIX32-NEXT:    nop
; AIX32-NEXT:    lwz r31, 60(r1) # 4-byte Folded Reload
; AIX32-NEXT:    addi r1, r1, 64
; AIX32-NEXT:    lwz r0, 8(r1)
; AIX32-NEXT:    mtlr r0
; AIX32-NEXT:    blr
;
; LINUX64LE-LABEL: print_func:
; LINUX64LE:       # %bb.0: # %entry
; LINUX64LE-NEXT:    mflr r0
; LINUX64LE-NEXT:    .cfi_def_cfa_offset 48
; LINUX64LE-NEXT:    .cfi_offset lr, 16
; LINUX64LE-NEXT:    .cfi_offset r30, -16
; LINUX64LE-NEXT:    std r30, -16(r1) # 8-byte Folded Spill
; LINUX64LE-NEXT:    stdu r1, -48(r1)
; LINUX64LE-NEXT:    addis r3, r2, .L_MergedGlobals@toc@ha
; LINUX64LE-NEXT:    std r0, 64(r1)
; LINUX64LE-NEXT:    addi r30, r3, .L_MergedGlobals@toc@l
; LINUX64LE-NEXT:    mr r3, r30
; LINUX64LE-NEXT:    bl puts
; LINUX64LE-NEXT:    nop
; LINUX64LE-NEXT:    addi r3, r30, 15
; LINUX64LE-NEXT:    bl puts
; LINUX64LE-NEXT:    nop
; LINUX64LE-NEXT:    addi r1, r1, 48
; LINUX64LE-NEXT:    ld r0, 16(r1)
; LINUX64LE-NEXT:    ld r30, -16(r1) # 8-byte Folded Reload
; LINUX64LE-NEXT:    mtlr r0
; LINUX64LE-NEXT:    blr
;
; LINUX64BE-LABEL: print_func:
; LINUX64BE:       # %bb.0: # %entry
; LINUX64BE-NEXT:    mflr r0
; LINUX64BE-NEXT:    stdu r1, -128(r1)
; LINUX64BE-NEXT:    std r0, 144(r1)
; LINUX64BE-NEXT:    .cfi_def_cfa_offset 128
; LINUX64BE-NEXT:    .cfi_offset lr, 16
; LINUX64BE-NEXT:    .cfi_offset r30, -16
; LINUX64BE-NEXT:    addis r3, r2, .L_MergedGlobals@toc@ha
; LINUX64BE-NEXT:    std r30, 112(r1) # 8-byte Folded Spill
; LINUX64BE-NEXT:    addi r30, r3, .L_MergedGlobals@toc@l
; LINUX64BE-NEXT:    mr r3, r30
; LINUX64BE-NEXT:    bl puts
; LINUX64BE-NEXT:    nop
; LINUX64BE-NEXT:    addi r3, r30, 15
; LINUX64BE-NEXT:    bl puts
; LINUX64BE-NEXT:    nop
; LINUX64BE-NEXT:    ld r30, 112(r1) # 8-byte Folded Reload
; LINUX64BE-NEXT:    addi r1, r1, 128
; LINUX64BE-NEXT:    ld r0, 16(r1)
; LINUX64BE-NEXT:    mtlr r0
; LINUX64BE-NEXT:    blr
entry:
  %call = tail call signext i32 @puts(ptr noundef nonnull dereferenceable(1) @.str)
  %call1 = tail call signext i32 @puts(ptr noundef nonnull dereferenceable(1) @str)
  ret void
}
