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

	.section	.text,code
	.align	2
	.globl	__pic32_software_reset
	.set	nomips16
	.set	nomicromips
	.ent	__pic32_software_reset
	.type	__pic32_software_reset, @function
	
__pic32_software_reset:

	.frame	$sp,24,$31
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro

	di
	ehb

0:
	li	$3,0xaa990000
	lui	$2,%hi(SYSKEY)
	addiu	$3,$3,26197
	sw	$0,%lo(SYSKEY)($2)
	sw	$3,%lo(SYSKEY)($2)
	li	$3,0x55660000
	ori	$3,$3,0x99aa
	sw	$3,%lo(SYSKEY)($2)
	lui	$2,%hi(RSWRSTSET)
	li	$3,0x1
	sw	$3,%lo(RSWRSTSET)($2)
	lui	$2,%hi(RSWRST)
	lw	$2,%lo(RSWRST)($2)

	j	0b
	nop

	.set	macro
	.set	reorder

	.end	__pic32_software_reset
	.size	__pic32_software_reset, .-__pic32_software_reset
