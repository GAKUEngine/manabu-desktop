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

	builder->get_widget("server.Entry", serverEntry);
	builder->get_widget("secure.Switch", secureSwitch);

    builder->get_widget("user.Entry", userEntry);
    builder->get_widget("password.Entry", passwordEntry);

	builder->get_widget("toolbox.Switch", toolboxSwitch);

    builder->get_widget("engage.Button", engageButton);
	engageButton->signal_clicked().connect(sigc::mem_fun(this, &Manabu::Desktop::Login::onEngage));

    window->show();
}

void Manabu::Desktop::Login::onEngage()
{

}
