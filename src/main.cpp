#include <gtkmm.h>
#include "manabu/desktop/login.h"
#include <stdio.h>

void loginCallback() {
	printf("%s\n", "login!!!");
}

int main(int argc, char *argv[])
{
	Gtk::Main kit(argc, argv);

	// Launch the login screen
	Manabu::Desktop::Login* loginScreen = Manabu::Desktop::Login::getInstance();
	loginScreen->setCallback(loginCallback);

	kit.run(*loginScreen);

	return 0;
}
