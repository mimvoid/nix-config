# dwm version
VERSION = 6.5

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# includes and libs
# TODO: add font lib?
INCS = -I${X11INC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS}

# Optional compiler optimisations may create smaller binaries and
# faster code, but increases compile time.
# See https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
OPTIMISATIONS = -march=native -mtune=native -flto=auto -O3

# flags
CPPFLAGS = -D_BSD_SOURCE -D_POSIX_C_SOURCE=2 -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
#CFLAGS   = -g -std=c99 -pedantic -Wall -O0 ${INCS} ${CPPFLAGS}
CFLAGS   = ${OPTIMISATIONS} -std=c99 -pedantic -Wall -Os ${INCS} ${CPPFLAGS}
LDFLAGS  = -s ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
