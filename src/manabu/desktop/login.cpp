#include "login.h"
#include "session.h"
#include "dash.h"

#include <iostream>
#include <regex>
using namespace std;

#include <glibmm/i18n.h>

Manabu::Desktop::Login::Login(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder)
				: Gtk::Window(cobject)
{
}

Manabu::Desktop::Login::~Login()
{
}

Manabu::Desktop::Login* Manabu::Desktop::Login::getInstance()
{
	clog << "Creating Login screen..." << endl;
	Login *screen;
    Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_resource("/layouts/login.glade");

    builder->get_widget_derived("login.Window", screen);

	builder->get_widget("status.Label", screen->statusLabel);
	screen->statusLabel->set_text(_("ready"));

	Gtk::Label *serverLabel, *userLabel, *passwordLabel;
	builder->get_widget("server.Label", serverLabel);
	serverLabel->set_text(_("server"));
	builder->get_widget("user.Label", userLabel);
	userLabel->set_text(_("user"));
	builder->get_widget("password.Label", passwordLabel);
	passwordLabel->set_text(_("password"));

	builder->get_widget("server.Entry", screen->serverEntry);
	builder->get_widget("secure.Switch", screen->secureSwitch);

    builder->get_widget("user.Entry", screen->userEntry);
    builder->get_widget("password.Entry", screen->passwordEntry);


    builder->get_widget("engage.Button", screen->engageButton);
	screen->engageButton->signal_clicked().connect(sigc::mem_fun(screen, &Login::onEngage));
	screen->engageButton->set_label(_("engage"));

    return screen;
}

void Manabu::Desktop::Login::onEngage()
{
	Session::manabu = new Manabu();

	this->statusLabel->set_text(_("trying_to_connect"));
	string protocol = "https"; // Default to HTTPS
	if (!this->secureSwitch->get_state()) { // Set to HTTP if switch is off
	 	protocol = "http";
	}

	unsigned int port = 80;
	string host = this->serverEntry->get_text();
	if (host.length() == 0) { // If no host is in the host field assume a local instance
		protocol = "http";
		host = "localhost";
		port = 9000;
	} else { // Check host field for port information
		regex re(R"(:\d+)");
		smatch m;
		regex_search(host, m, re);
		port = stoi(m.str().substr(1, m.str().length() - 1));
		host = host.substr(0, host.length() - m.str().length());
	}

	clog << "Attempting to connect to [" << protocol << "://" << host << ":" << port << "]..." \
		<< endl;
	if (Session::manabu->connect(protocol, host, port)) {
		clog << "Successfully connected to server." << endl;
		this->statusLabel->set_text(_("connected_to_server"));
	} else {
		cerr << "Couldn't connect to server." << endl;
		this->statusLabel->set_text(_("could_not_connect_to_server"));
	}

	string user = this->userEntry->get_text();
	string password = this->passwordEntry->get_text();
	clog << "Attempting to authenticate..." << endl;
	if (Session::manabu->authenticate(user, password)) {
		clog << "Authentication successful. Opening Dashboard." << endl;
		this->statusLabel->set_text(_("authenticated"));
		this->callback();
	} else {
		cerr << "Authentication failed!" << endl;
		this->statusLabel->set_text(_("authentication_failed"));
	}
}

void Manabu::Desktop::Login::setCallback(void (callback)(void))
{
	this->callback = callback;
}
