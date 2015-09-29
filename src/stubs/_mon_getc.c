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

extern int __XC_UART;
extern __attribute__ ((noinline,nomips16,weak)) int _appio_getc (int canblock);
extern __attribute__ ((noinline,nomips16,weak)) int _p32mxsk_getc (int canblock);

#ifndef _U1MODE_UARTEN_POSITION
#define _U1MODE_UARTEN_POSITION                 0x0000000F
#endif

#ifndef _U1STA_UTXEN_POSITION
#define _U1STA_UTXEN_POSITION                   0x0000000A
#endif

#ifndef _U1STA_TRMT_POSITION
#define _U1STA_TRMT_POSITION                    0x00000008
#endif

#ifndef _U1STA_URXDA_POSITION
#define _U1STA_URXDA_POSITION                   0x00000000
#endif

extern volatile unsigned int U1MODE __attribute__((weak,section("sfrs")));
extern volatile unsigned int U1STA __attribute__((weak,section("sfrs")));
extern volatile unsigned int U1MODESET __attribute__((weak,section("sfrs")));
extern volatile unsigned int U1STASET __attribute__((weak,section("sfrs")));
extern volatile unsigned int U1RXREG __attribute__((weak,section("sfrs")));
extern volatile unsigned int U1TXREG __attribute__((weak,section("sfrs")));
extern volatile unsigned int U1BRG __attribute__((weak,section("sfrs")));

extern volatile unsigned int U2MODE __attribute__((weak,section("sfrs")));
extern volatile unsigned int U2STA __attribute__((weak,section("sfrs")));
extern volatile unsigned int U2MODESET __attribute__((weak,section("sfrs")));
extern volatile unsigned int U2STASET __attribute__((weak,section("sfrs")));
extern volatile unsigned int U2RXREG __attribute__((weak,section("sfrs")));
extern volatile unsigned int U2TXREG __attribute__((weak,section("sfrs")));
extern volatile unsigned int U2BRG __attribute__((weak,section("sfrs")));

int __attribute__((weak))
_mon_getc (int canblock)
{
  int i;
  volatile unsigned int *umode = &U1MODE;
  volatile unsigned int *umodeset = &U1MODESET;
  volatile unsigned int *ustatus = &U1STA;
  volatile unsigned int *ustatusset = &U1STASET;
  volatile unsigned int *rxreg = &U1RXREG;
  volatile unsigned int *brg = &U1BRG;

  if (__XC_UART == 0)
    {
      if (_appio_getc)
        return _appio_getc (canblock);
      if (_p32mxsk_getc)
        return _p32mxsk_getc (canblock);
    }
  else if (__XC_UART == 2)
    {
      umode = &U2MODE;
      ustatus = &U2STA;
      rxreg = &U2RXREG;
      brg = &U2BRG;
    }
  if ((*umode & (1 << _U1MODE_UARTEN_POSITION)) == 0)
    {
      *umodeset = (1 << _U1MODE_UARTEN_POSITION);
    }
  {
    int nTimeout;

    /*
    ** Timeout is 16 cycles per 10-bit char
    */
    nTimeout = 16*10;
    while (((*ustatus & (1 << _U1STA_URXDA_POSITION)) == 0) && nTimeout) --nTimeout;
    return *rxreg;
  }

  return -1;
}

