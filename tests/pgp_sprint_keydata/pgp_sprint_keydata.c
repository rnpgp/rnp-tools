
#include <stddef.h>
#include <string.h>
#include <netpgp.h>

int main(int argc, char *argv[])
{
	netpgp_t netpgp;

	memset((void *) &netpgp, '\0', sizeof(netpgp));
	if (netpgp_init(&netpgp)) {
		netpgp_list_keys(&netpgp, 1);
		netpgp_end(&netpgp);
	}
	return 0;
}
