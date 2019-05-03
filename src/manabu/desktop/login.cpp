#include "login.h"

Manabu::Desktop::Login::Login(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder)
				: Gtk::Window(cobject)
{
}

Manabu::Desktop::Login::~Login()
{
}

Manabu::Desktop::Login* Manabu::Desktop::Login::getInstance()
{
	Login* screen;
    Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_resource("/layouts/login.glade");

    builder->get_widget_derived("login.Window", screen);

	builder->get_widget("server.Entry", screen->serverEntry);
	builder->get_widget("secure.Switch", screen->secureSwitch);

    builder->get_widget("user.Entry", screen->userEntry);
    builder->get_widget("password.Entry", screen->passwordEntry);

	builder->get_widget("toolbox.Switch", screen->toolboxSwitch);

    builder->get_widget("engage.Button", screen->engageButton);
	screen->engageButton->signal_clicked().connect(sigc::mem_fun(screen, &Manabu::Desktop::Login::onEngage));

    return screen;
}

void Manabu::Desktop::Login::onEngage()
{

}
