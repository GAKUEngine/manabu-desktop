#include "login.h"

Manabu::Desktop::Login::Login()
{
	Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_resource("/layouts/login.glade");
	//builder->get_widget("login.Window", ???); <恐らくこの???に何かを入れればok?
}

Manabu::Desktop::Login::~Login()
{
}
