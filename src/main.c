/*
 * MIT License
 *
 * Copyright (c) 2025 Thierry Le Got
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <cmoc.h>
#include <mo5_defs.h>
#include <mo5_stdio.h>

/* ========================================
 * CONSTANTS
 * ======================================== */

#define MAX_NAME_LENGTH 30

/* ========================================
 * MAIN PROGRAM
 * ======================================== */

void mo5_clear_buffer(char* buffer, int size)
{
    int i;
    for (i = 0; i < size; i++) {
        buffer[i] = '\0';
    }
}

void mo5_wait_key(char key)
{
    char ch;

    // Wait for the specific key - ignore all invalid characters
    do {
        ch = getchar();
    } while (ch != key);
}

int main(void)
{
    char name[MAX_NAME_LENGTH + 1];  // +1 for null terminator

    // Infinite loop to greet multiple people
    while (1) {
        // Clear screen for clean display
        clrscr();
        //mo5_clear_buffer(name, MAX_NAME_LENGTH + 1);
        memset(name, 0, MAX_NAME_LENGTH + 1);
        // Display welcome prompt
        fputs("What is your first name?\r\n");

        // Read user input
        int size = fgets(name, MAX_NAME_LENGTH);
        fputs("\r\n");

        // Display personalized greeting
        fputs("Hello "); fputs(name); fputs("!\r\n");

        // Wait for 'Y' key before next iteration
        fputs("\r\n");
        fputs("Press Y to continue...");
        mo5_wait_key('Y');
    }

    return 0;
}

