#include <gtkmm.h>
#include "manabu/desktop/login.h"

int main(int argc, char *argv[])
{
	Gtk::Main kit(argc, argv);

	// Launch the login screen
	Manabu::Desktop::Login loginScreen = Manabu::Desktop::Login();

	kit.run();

	return 0;
}
