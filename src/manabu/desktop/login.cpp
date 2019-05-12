#include "login.h"
#include "session.h"

#include <iostream>
using namespace std;

Manabu::Desktop::Login::Login(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder)
				: Gtk::Window(cobject)
{
}

Manabu::Desktop::Login::~Login()
{
}

Manabu::Desktop::Login* Manabu::Desktop::Login::getInstance()
{
	clog << "Creating login screen..." << endl;
	Login* screen;
    Glib::RefPtr<Gtk::Builder> builder = Gtk::Builder::create_from_resource("/layouts/login.glade");

    builder->get_widget_derived("login.Window", screen);

	builder->get_widget("status.Label", screen->statusLabel);

	builder->get_widget("server.Entry", screen->serverEntry);
	builder->get_widget("secure.Switch", screen->secureSwitch);

    builder->get_widget("user.Entry", screen->userEntry);
    builder->get_widget("password.Entry", screen->passwordEntry);


    builder->get_widget("engage.Button", screen->engageButton);
	screen->engageButton->signal_clicked().connect(sigc::mem_fun(screen, &Login::onEngage));

    return screen;
}

void Manabu::Desktop::Login::onEngage()
{
	Session::manabu = new Manabu();

	this->statusLabel->set_text("Trying to connect...");
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
		// TODO regex for port
	}

	clog << "Attempting to connect to [" << protocol << "://" << host << ":" << port << "]..." \
		<< endl;
	if (Session::manabu->connect(protocol, host, port)) {
		clog << "Successfully connected to server." << endl;
		this->statusLabel->set_text("Connected to server.");
	} else {
		cerr << "Couldn't connect to server." << endl;
		this->statusLabel->set_text("Couldn't connect to server.");
	}

	string user = this->userEntry->get_text();
	string password = this->passwordEntry->get_text();
	clog << "Attempting to authenticate..." << endl;
	if (Session::manabu->authenticate(user, password)) {
		clog << "Authentication successful. Opening main menu." << endl;
		this->statusLabel->set_text("Authenticated.");
		this->callback();
	} else {
		cerr << "Authentication failed!" << endl;
		this->statusLabel->set_text("Authentication failed!");
	}
}

void Manabu::Desktop::Login::setCallback(void (callback)(void))
{
	this->callback = callback;
}
