
#ifndef _MANABU_DESKTOP_LOGIN_H_
#define _MANABU_DESKTOP_LOGIN_H_

#include <gtkmm.h>

namespace Manabu
{
	namespace Desktop
	{
		//! Displays a login screen
		class Login
		{
		private:
			void buildLoginScreen();

			void onEngage();

		public:
			Gtk::Window *window;
			Login();
			~Login();

        protected:
            Gtk::Entry *serverEntry, *userEntry, *passwordEntry;
			Gtk::Switch *secureSwitch, *toolboxSwitch;
            Gtk::Button *engageButton;
		};
	}
}


#endif /* _MANABU_DESKTOP_LOGIN_H_ */
