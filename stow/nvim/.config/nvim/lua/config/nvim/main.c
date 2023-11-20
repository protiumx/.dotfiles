#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUL '\000'

// https://github.com/neovim/neovim/blob/master/src/nvim/window.c
extern char *grab_file_name(int count, int32_t *file_lnum);
extern char *get_cursor_line_ptr(void);

// Return file name under cursor with line number if present
// Expects format file:line:column
char *file_under_cursor() {
  int32_t lnum = -1;
  char *ptr = grab_file_name(1, &lnum);
  if (ptr == NULL) {
    return NULL;
  }

  if (lnum == -1) {
    return ptr;
  }

  const int len = strlen(ptr);
  char *start = strstr(get_cursor_line_ptr(), ptr);
  int size = 0;
  char c = start[size];
  while (c != '\0' && c != ' ' && c != '\t') {
    size++;
    c = start[size];
  }

  if (size == 0) {
    // Use lnum, format might be `file line xxx`
    char *ret;
    sprintf(ret, "%s:%d", ptr, lnum);
  }

  char *ret = (char *)malloc(len + size + 1);
  memcpy(ret, start, len + size);

  ret[len + size] = '\0';

  return ret;
}
