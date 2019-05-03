
#ifndef _MANABU_DESKTOP_LOGIN_H_
#define _MANABU_DESKTOP_LOGIN_H_

#include <gtkmm.h>

namespace Manabu
{
	namespace Desktop
	{
		//! Displays a login screen
		class Login : public Gtk::Window
		{
		private:
			void buildLoginScreen();

			void onEngage();

		public:
			Gtk::Window *window;
			Login();
			Login(BaseObjectType* cobject, const Glib::RefPtr<Gtk::Builder>& refBuilder);
			~Login();

			static Manabu::Desktop::Login* getInstance();

        protected:
            Gtk::Entry *serverEntry, *userEntry, *passwordEntry;
			Gtk::Switch *secureSwitch, *toolboxSwitch;
            Gtk::Button *engageButton;
		};
	}
}


#endif /* _MANABU_DESKTOP_LOGIN_H_ */
