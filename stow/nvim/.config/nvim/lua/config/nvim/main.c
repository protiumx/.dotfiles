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
  char *file_name = grab_file_name(1, &lnum);
  if (file_name == NULL) {
    return NULL;
  }

  if (lnum == -1) {
    return file_name;
  }

  const int file_name_len = strlen(file_name);
  // position pointer at the end of the file_name in the current line
  char *pos_ptr = strstr(get_cursor_line_ptr(), file_name) + strlen(file_name);
  int pos_size = 0;
  char c = *pos_ptr;
  while (c != '\0' && c != ' ' && c != '\t') {
    pos_size++;
    c = pos_ptr[pos_size];
  }

  char *ret = NULL;
  if (pos_size == 0) {
    // Use lnum
    // allocate for ":" + lnum + \0, assume 4 digits is enough
    ret = (char *)malloc(file_name_len + 6);
    sprintf(ret, "%s:%d", file_name, lnum);
    free(file_name);
    return ret;
  }

  ret = (char *)malloc(file_name_len + pos_size + 1);
  strncpy(ret, file_name, file_name_len);
  strncpy(ret + file_name_len, pos_ptr, pos_size);
  ret[file_name_len + pos_size] = '\0';

  free(file_name);

  return ret;
}
