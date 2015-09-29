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
	.file 1 "Microchip PIC32 Library"
	.loc 1 0
#endif
	.text
	.align	2
	.weak	_nmi_handler
	.set	nomips16
	.ent	_nmi_handler
_nmi_handler:
	.frame	sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	
        mfc0    k0, _CP0_STATUS                   # retrieve STATUS
        lui     k1, ~(_CP0_STATUS_BEV_MASK >> 16) & 0xffff
        ori     k1, k1, ~_CP0_STATUS_BEV_MASK & 0xffff
        and     k0, k0, k1                        # Clear BEV
        mtc0    k0, _CP0_STATUS                   # store STATUS
        eret

	.set	macro
	.set	reorder
	.end	_nmi_handler
	.size	_nmi_handler, .-_nmi_handler

