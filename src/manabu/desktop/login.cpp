#include "login.h"
#include <manabu.h>
#include <stdio.h>

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
	screen->engageButton->signal_clicked().connect(sigc::mem_fun(screen, &Login::onEngage));

	return screen;
}

void Manabu::Desktop::Login::onEngage()
{
	Manabu* manabu = new Manabu();
	
	string host = "localhost";
	// if (strlen(this->serverEntry->get_text().c_str()) > 0) {
	// 	host = this->serverEntry->get_text().c_str();
	// }
	string protocol = "http";
	// if (this->secureSwitch->get_state()) {
	// 	protocol = "https";
	// }
	if (!manabu->connect(protocol, host)) {
		// TODO: 失敗通知
		printf("%s\n", "connect ng");
	}

	string user = this->userEntry->get_text().c_str();
	string password = this->passwordEntry->get_text().c_str();
	if (manabu->authenticate(user, password)) {
		// TODO: 画面移動
		this->callback();
		printf("%s\n", "authenticate ok");
	} else {
		// TODO: 失敗通知
		printf("%s\n", "authenticate ng");
	}
}

void Manabu::Desktop::Login::setCallback(void (callback)(void))
{
	this->callback = callback;
}
