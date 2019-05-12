#include "dash.h"
#include "session.h"

#include <iostream>
using namespace std;

Manabu::Desktop::Dash::Dash(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder)
				: Gtk::Window(cobject)
{
}

Manabu::Desktop::Dash::~Dash()
{
}

Manabu::Desktop::Dash* Manabu::Desktop::Dash::getInstance()
{
	clog << "Creating Dashboard screen..." << endl;
	Dash *screen;
    Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_resource("/layouts/dash.glade");

    builder->get_widget_derived("dash.Window", screen);

    return screen;
}
