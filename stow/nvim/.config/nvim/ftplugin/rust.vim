setlocal makeprg=cargo

setlocal errorformat=
			\%f:%l:%c:\ %t%*[^:]:\ %m,
			\%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m,
			\%-G%f:%l\ %s,
			\%-G%.%#suggestion%.%#,
			\%-G%*[\ ]^,
			\%-G%*[\ ]^%*[~],
			\%-G%*[\ ]...

setlocal errorformat+=
			\%-G,
			\%-Gerror:\ aborting\ %.%#,
			\%-Gerror:\ Could\ not\ compile\ %.%#,
			\%Eerror:\ %m,
			\%Eerror[E%n]:\ %m,
			\%Inote:\ %m

setlocal errorformat+=
			\%Wwarning:\ %m,%C\ %#-->\ %f:%l:%c,
      \%-G%.%#

setlocal errorformat+=
			\%-G%\\s%#Downloading%.%#,
			\%-G%\\s%#Compiling%.%#,
			\%-G%\\s%#Finished%.%#,
			\%-G%\\s%#error:\ Could\ not\ compile\ %.%#,
			\%-G%\\s%#To\ learn\ more\\,%.%#
