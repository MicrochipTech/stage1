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
/* This is a default definition of a general exception handler function.
 * It does nothing and just goes into an infinite loop. If the user
 * application supplies a handler function, this function will not be
 * referenced and thus not pulled in from the library.
 */
void 
__attribute__((weak, nomips16)) _general_exception_handler (void)
{
  __asm__ volatile (" sdbbp 0");
  while (1);
}
