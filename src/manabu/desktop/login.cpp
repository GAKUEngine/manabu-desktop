#include "login.h"

Manabu::Desktop::Login::Login()
{
	buildLoginScreen();
}

Manabu::Desktop::Login::~Login()
{
}

void Manabu::Desktop::Login::buildLoginScreen()
{
	Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_resource("/layouts/login.glade");
	builder->get_widget("login.Window", window);
	window->show();
}
