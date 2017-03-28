
#include <stddef.h>
#include <netpgp.h>

int main(int argc, char *argv[])
{
	netpgp_t netpgp;

	if (netpgp_init(&netpgp)) {
		netpgp_list_keys(&netpgp, 1);
		netpgp_end(&netpgp);
	}
	return 0;
}
