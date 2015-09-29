/*********************************************************************
  Copyright 2015 Microchip Technology, Inc.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
 **********************************************************************/
 
#include <xc.h>
#ifdef __LIBBUILD__
   .file 1 "general-exception.S"
   .loc 1 0
#endif
  ###################
  # Default general exception handler
  ###################

  .section .text.general_exception, code
  .set noreorder
  .set noat
  .globl _general_exception_context
  .ent _general_exception_context

_general_exception_context:

  # Save off the non-callee saved registers that may get mucked with
  addiu sp, sp, -88
  sw $1,  4(sp)
  sw v0,  8(sp)
  sw v1, 12(sp)
  sw a0, 16(sp)
  sw a1, 20(sp)
  sw a2, 24(sp)
  sw a3, 28(sp)
  sw t0, 32(sp)
  sw t1, 36(sp)
  sw t2, 40(sp)
  sw t3, 44(sp)
  sw t4, 48(sp)
  sw t5, 52(sp)
  sw t6, 56(sp)
  sw t7, 60(sp)
  sw t8, 64(sp)
  sw t9, 68(sp)
  sw ra, 72(sp)
  mflo t0
  sw t0, 76(sp)
  mfhi t0
  sw t0, 80(sp)

  # Pass Cause and Status to the handler function
  mfc0 a0, _CP0_CAUSE
  mfc0 a1, _CP0_STATUS
  jal _general_exception_handler
  nop

  lw t0, 80(sp)
  mthi t0
  lw t0, 76(sp)
  mtlo t0

  lw $1,  4(sp)
  lw v0,  8(sp)
  lw v1, 12(sp)
  lw a0, 16(sp)
  lw a1, 20(sp)
  lw a2, 24(sp)
  lw a3, 28(sp)
  lw t0, 32(sp)
  lw t1, 36(sp)
  lw t2, 40(sp)
  lw t3, 44(sp)
  lw t4, 48(sp)
  lw t5, 52(sp)
  lw t6, 56(sp)
  lw t7, 60(sp)
  lw t8, 64(sp)
  lw t9, 68(sp)
  lw ra, 72(sp)
  addiu sp, sp, 88

  ehb  # do we need this? Execution hazard barriers?
  eret

  .end _general_exception_context

