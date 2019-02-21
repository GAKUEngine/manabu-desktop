#include <gtkmm.h>
#include "manabu/desktop/login.h"

int main(int argc, char *argv[])
{
	Gtk::Main kit(argc, argv);

	// Launch the login screen
	Manabu::Desktop::Login loginScreen;

	kit.run(loginScreen);

	return 0;
}
