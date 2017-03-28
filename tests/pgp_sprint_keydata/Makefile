#
# Makefile

CFLAGS+= -std=c99
LDFLAGS+= -lnetpgp

all: test

clean:
	$(RM) *.o test

test: pgp_sprint_keydata.o
	$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

.PHONY: all
