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
/* Outputs count bytes of a string using _mon_putc */
void __attribute__((weak))
_mon_write (const char * s, unsigned int count)
{
  /* Do not try to output an empty string */
  if (!s)
    return;

  /* Output the string character-by-character to the UART */
  while (count)
    {
      _mon_putc (*s);
      s++;
      count--;
    }
}

