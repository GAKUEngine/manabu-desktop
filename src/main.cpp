#include <gtkmm.h>
#include "manabu/desktop/login.h"
#include "manabu/desktop/dash.h"
#include <iostream>
using namespace std;

#include <glibmm/i18n.h>

static Gtk::Main *kit;
Manabu::Desktop::Login* loginScreen;
Manabu::Desktop::Dash* dashScreen;

// When login succeeds, hide the Login screen and display the Dashboard
void loginCallback() {
	clog << "Hiding Login and displaying Dashboard..." << endl;

	dashScreen = Manabu::Desktop::Dash::getInstance();
	loginScreen->hide();
	kit->run(*dashScreen);
	loginScreen->remove();
	delete loginScreen;
}

int main(int argc, char* argv[])
{
	// TODO: switch locale
	setlocale(LC_ALL, "");
	setenv("LANG", "ja_JP.utf8", 1);
	bindtextdomain("manabu", "./../locales");
	textdomain("manabu");

	kit = new Gtk::Main(argc, argv);

	// Launch the Login screen
	clog << "Displaying Login..." << endl;
	loginScreen = Manabu::Desktop::Login::getInstance();
	loginScreen->setCallback(loginCallback);

	kit->run(*loginScreen);

	return 0;
}
